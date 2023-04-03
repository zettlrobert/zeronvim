local M = {}

M.tabnew = function()
  local command = "tabnew"
  vim.api.nvim_command(command)
  vim.notify("New tab opened")
end

M.tabclose = function()
  local command = "tabclose"
  vim.api.nvim_command(command)
end

return M
