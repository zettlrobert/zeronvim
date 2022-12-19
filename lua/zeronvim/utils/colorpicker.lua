local M = {}

M.toggle_color_picker = function()
  local command = "CccPick"
  vim.api.nvim_command(command)
end

return M
