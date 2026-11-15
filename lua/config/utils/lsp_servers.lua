local M = {}

--[[
Picker over every configured LSP server (everything with an after/lsp/<name>.lua),
showing each server's state for the current buffer. Selecting an item:
  ✕ disabled (persisted) → turn it on everywhere (toggle_lsp_server.set)
  ● attached             → turn it off everywhere (persisted)
  ○ not attached         → attach it to this buffer only (attach_here)

Useful for:
  - Toggling servers on-demand without per-server keymaps
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

---Build the picker items: every configured server with its current attach
---state and its persistent-disabled flag (from toggle_lsp_server's state file).
local function server_states(bufnr)
  local servers = require("config.lsp").servers_from_dir()
  local attached = attached_by_name(bufnr)
  local toggle = require("config.utils.toggle_lsp_server")
  local items = {}
  for _, name in ipairs(servers) do
    table.insert(items, {
      name = name,
      attached = attached[name] or false,
      disabled = toggle.is_disabled(name),
    })
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
      local marker
      local state
      if item.disabled then
        marker = "✕ "
        state = "disabled (persisted)"
      elseif item.attached then
        marker = "● "
        state = "attached"
      else
        marker = "○ "
        state = "not attached"
      end
      return ("%s%-30s  %s"):format(marker, item.name, state)
    end,
  }, function(choice)
    if not choice then
      return
    end
    local toggle = require("config.utils.toggle_lsp_server")
    if choice.disabled then
      toggle.set(choice.name, true)
    elseif choice.attached then
      toggle.set(choice.name, false)
    else
      toggle.attach_here(choice.name, bufnr)
    end
  end)
end

M.lsp_servers = lsp_servers

return M
