local utils = require "zeronvim.utils"
local ibl = utils.protected_plugin_call("ibl")

if ibl then
  ibl.setup()
end
