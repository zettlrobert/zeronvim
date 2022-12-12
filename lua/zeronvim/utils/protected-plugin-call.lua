-- Function to call plugins in a protected way availalbe with custom utils
local function protectedPluginCall(plugin)
  local status_ok, initializedPlugin = pcall(require, plugin)
  if not status_ok then
    vim.notify("ERROR: Could not require " .. plugin .. initializedPlugin)
    return
  else
    return initializedPlugin
  end
end

return protectedPluginCall
