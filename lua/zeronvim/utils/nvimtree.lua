local M = {}

M.nvim_tree_find_file = function()
  local command = "NvimTreeFindFile"
  vim.api.nvim_command(command)
end

return M
