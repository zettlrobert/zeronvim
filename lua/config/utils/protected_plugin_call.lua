local M = {}

-- make a protected call to require and use it to load a module
M.protected_plugin_call = function()
  local status_ok, response_data = pcall(require, plugin)
  if status_ok then
    return response_data
  else
    vim.notify(response_data, vim.log.levels.ERROR)
  end
end

return M
