local M = {}

---Returns the current working directory via the vim fn api
---@return string
M.get_current_working_directory = function()
  local current_working_directory = vim.fn.getcwd()
  return current_working_directory
end

return M
