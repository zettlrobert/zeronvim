local M = {}

---Returns the project name via lua string matching
---@return string
M.get_project_name = function()
  local project_name = string.match(vim.fn.getcwd(), "/(%w+)$")
  return project_name or vim.fn.getcwd()
end

return M
