-- Utils Module Table - Making every Utility Function availalbe
local utils = {}
utils.protected_plugin_call = require "zeronvim.utils.protected-plugin-call"
utils.sourcing = require "zeronvim.utils.sourcing"
utils.get_filename = require "zeronvim.utils.get-filename"
utils.get_file_extension = require "zeronvim.utils.get-file-extension"
utils.is_input_empty = require "zeronvim.utils.is-input-empty"

-- Expose Module to configuration
return utils
