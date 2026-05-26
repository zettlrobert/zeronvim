local M = {}

--[[
Toggle an LSP server's attach state. Once toggled OFF, the server stays
detached for the rest of the session AND across nvim restarts (state is
persisted to ~/.local/state/nvim/lsp-toggles.json). Toggling ON re-enables
auto-attach for new buffers that match and immediately attaches to the
current buffer.

One flag per server: disabled[server_name] = true means "user wants this
off everywhere, even after restart".

A LspAttach autocmd detaches any client of a disabled server the moment
it tries to attach. That's what makes the toggle stick across :e, new
file opens, AND nvim restarts (where the state file is reloaded on startup
before any buffer events fire).

Useful as an escape hatch for noisy linters (e.g. vale-ls) when you don't
want them anywhere — even when you come back to nvim tomorrow.
]]

local state_path = vim.fn.stdpath("state") .. "/lsp-toggles.json"

-- disabled[server_name] = true means user toggled it off
local disabled = {}

---Load the disabled set from disk. Best-effort: any read/parse failure
---leaves us with an empty set (the toggle still works for this session).
local function load_state()
  local f = io.open(state_path, "r")
  if not f then
    return
  end
  local content = f:read("*a")
  f:close()
  if not content or content == "" then
    return
  end
  local ok, parsed = pcall(vim.json.decode, content)
  if ok and type(parsed) == "table" and type(parsed.disabled) == "table" then
    disabled = parsed.disabled
  end
end

---Save the disabled set to disk. Atomic write via temp + rename so a crash
---mid-write doesn't corrupt the state file.
local function save_state()
  local tmp = state_path .. ".tmp"
  local f = io.open(tmp, "w")
  if not f then
    return
  end
  f:write(vim.json.encode({ disabled = disabled }))
  f:close()
  os.rename(tmp, state_path)
end

load_state()

-- Re-apply the disabled state on every LSP attach. This is what makes the
-- toggle stick across :e, across newly-opened files, and across restarts
-- (state is loaded above before any LspAttach can fire).
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ToggleLspServerPersistDisabled", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and disabled[client.name] then
      vim.lsp.buf_detach_client(ev.buf, client.id)
    end
  end,
})

---Whether the given server is in the persistent disabled set.
---Used by the lsp_servers picker to surface state visually.
function M.is_disabled(name)
  return disabled[name] == true
end

local toggle_lsp_server = function(name)
  local bufnr = vim.api.nvim_get_current_buf()
  local title = "LSP toggle"

  if disabled[name] then
    -- Currently disabled → re-enable globally and attach to current buffer
    disabled[name] = nil
    save_state()

    local config = vim.lsp.config[name]
    if not config then
      vim.notify(("%s: no config registered"):format(name), vim.log.levels.WARN, { title = title })
      return
    end

    local final_config = vim.tbl_deep_extend("force", config, { name = name })
    local ok, client_id = pcall(vim.lsp.start, final_config, { bufnr = bufnr })
    if ok and client_id then
      vim.notify(("%s: enabled (persisted)"):format(name), vim.log.levels.INFO, { title = title })
    else
      vim.notify(
        ("%s: enabled but attach failed (%s)"):format(name, ok and "no client id returned" or tostring(client_id)),
        vim.log.levels.WARN,
        { title = title }
      )
    end
    return
  end

  -- Currently enabled → disable globally and detach from every attached buffer
  disabled[name] = true
  save_state()

  for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
    for attached_bufnr in pairs(client.attached_buffers or {}) do
      vim.lsp.buf_detach_client(attached_bufnr, client.id)
    end
  end

  vim.notify(("%s: disabled (persisted, survives restart)"):format(name), vim.log.levels.INFO, { title = title })
end

M.toggle_lsp_server = toggle_lsp_server

return M
