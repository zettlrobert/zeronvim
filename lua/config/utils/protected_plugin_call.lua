local M = {}

---Make a protected call to require and use it to load a module
---@param plugin string
---@return unknown
M.protected_plugin_call = function(plugin)
  local status_ok, response_data = pcall(require, plugin)
  if status_ok then
    return response_data
  else
    vim.notify(response_data, vim.log.levels.ERROR)
  end
end

return M
