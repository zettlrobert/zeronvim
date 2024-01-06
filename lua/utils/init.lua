local M = {}

M.protected_plugin = function(plugin)
  local status_ok, loaded_plugin = pcall(require, plugin)
  if status_ok then
    return loaded_plugin
  else
    error('Could not load plugin: ' .. plugin)
  end
end

M.get_user = function()
  local os = require('os')
  local user = os.getenv("USER")
  print(user)
  return user
end

M.get_user()

return M
