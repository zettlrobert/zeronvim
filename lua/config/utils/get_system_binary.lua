local M = {}

--- Return the absolute path of an executable on $PATH, or nil if it is missing.
--- (The previous `whereis` version returned "name: path manpages" and never
--- reported a missing binary.)
---@param binary string
---@return string? path
M.get_system_binary = function(binary)
  local path = vim.fn.exepath(binary)
  if path == "" then
    return nil
  end
  return path
end

return M
