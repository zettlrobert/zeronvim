local M = {}

--[[
Persisted per-server LSP on/off switch, built on Neovim 0.12's
vim.lsp.enable(name, on):

  - OFF: vim.lsp.enable(name, false) stops the server's clients and keeps it
    from attaching again. The name is saved to
    ~/.local/state/nvim/lsp-toggles.json, and lua/config/lsp/init.lua skips
    vim.lsp.enable for saved names at startup, so it stays off after restart.
  - ON: vim.lsp.enable(name) attaches to every matching buffer now and later.
    If the current buffer still has no client (its filetype is not in the
    server's filetypes, e.g. the on-demand vale_ls), attach_here() starts
    it for this buffer only.

Useful as an escape hatch for noisy linters (e.g. vale-ls).
]]

local state = require("config.utils.state")
local STATE = "lsp-toggles" -- ~/.local/state/nvim/lsp-toggles.json

-- disabled[server_name] = true means user toggled it off
local disabled = {}

---Load the disabled set from disk. Best-effort: any read/parse failure
---leaves us with an empty set (the toggle still works for this session).
local function load_state()
  local parsed = state.read(STATE)
  if parsed and type(parsed.disabled) == "table" then
    disabled = parsed.disabled
  end
end

local function save_state()
  state.write(STATE, { disabled = disabled })
end

load_state()

---Whether the given server is in the persistent disabled set.
---Used by the lsp_servers picker to surface state visually.
function M.is_disabled(name)
  return disabled[name] == true
end

local title = "LSP toggle"

---Start `name` for one buffer, whatever its filetype. Resolves root_dir the
---way vim.lsp.enable does (root_dir function, else root_markers), which a bare
---vim.lsp.start(config) would skip.
---@param name string
---@param bufnr? integer
---@return boolean started
function M.attach_here(name, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local config = vim.lsp.config[name]
  if not config then
    vim.notify(("%s: no config registered"):format(name), vim.log.levels.WARN, { title = title })
    return false
  end
  config = vim.deepcopy(config)
  config.name = name

  local function start(root)
    config.root_dir = root
    local ok, client_id = pcall(vim.lsp.start, config, { bufnr = bufnr })
    if not (ok and client_id) then
      vim.notify(
        ("%s: attach failed (%s)"):format(name, ok and "no client id returned" or tostring(client_id)),
        vim.log.levels.WARN,
        { title = title }
      )
    end
    return ok and client_id ~= nil
  end

  if type(config.root_dir) == "function" then
    config.root_dir(bufnr, start) -- async; start() reports failures itself
    return true
  end
  return start(config.root_dir or vim.fs.root(bufnr, config.root_markers or {}))
end

---Turn a server on or off everywhere and persist the choice.
---@param name string
---@param on boolean
function M.set(name, on)
  disabled[name] = (not on) or nil
  save_state()
  vim.lsp.enable(name, on)

  if not on then
    vim.notify(("%s: disabled (persisted, survives restart)"):format(name), vim.log.levels.INFO, { title = title })
    return
  end

  -- vim.lsp.enable attaches through the FileType autocmds it re-runs; give
  -- that a tick, then attach here if this buffer's filetype did not match.
  local bufnr = vim.api.nvim_get_current_buf()
  vim.schedule(function()
    if #vim.lsp.get_clients({ bufnr = bufnr, name = name }) == 0 then
      M.attach_here(name, bufnr)
    end
    vim.notify(("%s: enabled (persisted)"):format(name), vim.log.levels.INFO, { title = title })
  end)
end

---Flip the persisted state: disabled → on, otherwise → off.
---@param name string
local toggle_lsp_server = function(name)
  M.set(name, disabled[name] == true)
end

M.toggle_lsp_server = toggle_lsp_server

return M
