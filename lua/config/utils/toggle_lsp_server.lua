local M = {}

--[[
Toggle an LSP server's attach state on the current buffer. Detaches if any
client with the given name is attached; otherwise calls vim.lsp.start with
the registered config to attach (reusing the running client if present).

State persistence: the disabled set is keyed by (server_name, full_file_path).
A LspAttach autocmd re-detaches if the user previously toggled the server off
for this file — so :e (or any other re-attach) doesn't silently undo the
toggle. State is session-only (cleared on nvim restart).

Useful as an escape hatch for noisy linters (e.g. vale-ls) when working on
documents whose style intentionally diverges from the configured rules.
]]

-- disabled[server_name][file_path] = true
local disabled = {}

local function file_path(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  return name ~= "" and name or nil
end

local function is_disabled(server_name, bufnr)
  local path = file_path(bufnr)
  if not path then return false end
  return disabled[server_name] and disabled[server_name][path] or false
end

local function mark_disabled(server_name, bufnr)
  local path = file_path(bufnr)
  if not path then return end
  disabled[server_name] = disabled[server_name] or {}
  disabled[server_name][path] = true
end

local function mark_enabled(server_name, bufnr)
  local path = file_path(bufnr)
  if not path then return end
  if disabled[server_name] then
    disabled[server_name][path] = nil
  end
end

-- Re-apply the disabled state on every LSP attach. This is the bit that makes
-- the toggle survive :e — without it, the file's FileType autocmd re-attaches
-- and the toggle is silently undone.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ToggleLspServerPersistDisabled", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and is_disabled(client.name, ev.buf) then
      vim.lsp.buf_detach_client(ev.buf, client.id)
    end
  end,
})

local toggle_lsp_server = function(name)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = name })
  local title = "LSP toggle"

  if #clients > 0 then
    for _, client in ipairs(clients) do
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
    mark_disabled(name, bufnr)
    vim.notify(("%s: detached (persists across :e)"):format(name), vim.log.levels.INFO, { title = title })
    return
  end

  -- Clear the disabled flag BEFORE attaching, otherwise the LspAttach autocmd
  -- will immediately undo our work.
  mark_enabled(name, bufnr)

  -- Resolve the merged config (nvim-lspconfig defaults + user override from
  -- lsp/<name>.lua). vim.lsp.start reuses the running client (matched on name
  -- + root_dir) and attaches it to bufnr — :LspStart alone wouldn't re-attach
  -- because the client is already running globally after a detach.
  local config = vim.lsp.config[name]
  if not config then
    vim.notify(("%s: no config registered"):format(name), vim.log.levels.WARN, { title = title })
    return
  end

  local final_config = vim.tbl_deep_extend("force", config, { name = name })
  local ok, client_id = pcall(vim.lsp.start, final_config, { bufnr = bufnr })
  if ok and client_id then
    vim.notify(("%s: attached to buffer"):format(name), vim.log.levels.INFO, { title = title })
  else
    vim.notify(
      ("%s: attach failed (%s)"):format(name, ok and "no client id returned" or tostring(client_id)),
      vim.log.levels.WARN,
      { title = title }
    )
  end
end

M.toggle_lsp_server = toggle_lsp_server

return M
