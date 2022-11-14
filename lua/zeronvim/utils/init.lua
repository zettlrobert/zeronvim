-- Utils Module Table - Making every Utility Function availalbe
local utils = {}
utils.protected_plugin_call = require "zeronvim.utils.protected-plugin-call"
utils.sourcing = require "zeronvim.utils.sourcing"

-- Expose Module to configuration
return utils
