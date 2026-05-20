local M = {}

--[[
Picker over every configured LSP server (everything with a lsp/<name>.lua),
showing each server's attach state for the current buffer. Selecting an item
dispatches to toggle_lsp_server — attached → detached, detached → attached.

Useful for:
  - Toggling experimental servers (tsgo) on-demand without per-server keymaps
  - Quickly silencing a noisy linter (vale_ls)
  - Seeing at a glance what's wired up vs what's attached right now

Source of truth for the list is the same scan that drives vim.lsp.enable:
config.lsp.servers_from_dir(). Add or remove servers by dropping/deleting
files in ~/.config/nvim/lsp/ — the picker picks them up automatically.
]]

---Map of LSP client name → true for clients attached to the given buffer.
local function attached_by_name(bufnr)
  local map = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    map[client.name] = true
  end
  return map
end

---Build the picker items: every configured server with its current attach state.
local function server_states(bufnr)
  local servers = require("config.lsp").servers_from_dir()
  local attached = attached_by_name(bufnr)
  local items = {}
  for _, name in ipairs(servers) do
    table.insert(items, { name = name, attached = attached[name] or false })
  end
  return items
end

local lsp_servers = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local items = server_states(bufnr)

  if #items == 0 then
    vim.notify("No LSP servers configured", vim.log.levels.WARN, { title = "LSP servers" })
    return
  end

  vim.ui.select(items, {
    prompt = "Toggle LSP server",
    kind = "lsp_servers",
    format_item = function(item)
      local marker = item.attached and "● " or "○ "
      local state = item.attached and "attached" or "not attached"
      return ("%s%-30s  %s"):format(marker, item.name, state)
    end,
  }, function(choice)
    if choice then
      require("config.utils").toggle_lsp_server(choice.name)
    end
  end)
end

M.lsp_servers = lsp_servers

return M
