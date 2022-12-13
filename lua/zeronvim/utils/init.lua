-- Utils Module Table - Making every Utility Function availalbe
local utils = {}
utils.protected_plugin_call = require "zeronvim.utils.protected-plugin-call"
utils.sourcing = require "zeronvim.utils.sourcing"
utils.get_filename = require "zeronvim.utils.get-filename"
utils.get_file_extension = require "zeronvim.utils.get-file-extension"
utils.is_input_empty = require "zeronvim.utils.is-input-empty"
utils.get_buf_option = require "zeronvim.utils.get-buf-option"
utils.merge_tables = require "zeronvim.utils.merge-tables"
utils.spelling = require "zeronvim.utils.spelling"

-- Expose Module to configuration
return utils
