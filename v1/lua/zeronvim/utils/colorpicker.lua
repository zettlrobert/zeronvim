local M = {}

M.toggle_color_picker = function()
  vim.api.nvim_command("CccPick")
end

return M
