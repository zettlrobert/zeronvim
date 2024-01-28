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
  return user
end

M.get_system_binary = function(binary)
  local handle = io.popen("whereis " .. binary)

  if handle then
    local binary_path = handle:read("*a")
    handle:close()

    -- Trim white space
    binary_path = binary_path:gsub("^%s*(.-)%s*$", "%1")

    if binary_path == "" then
      vim.notify("Could not find system binary: " .. binary)
      return nil
    end

    return binary_path
  end
end

return M
