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
utils.get_icons = require "zeronvim.utils.get_icons"
utils.get_title_string = require "zeronvim.utils.get_titlestring"
utils.debugger = require "zeronvim.utils.debugger"
utils.colorpicker = require "zeronvim.utils.colorpicker"
utils.wrap = require "zeronvim.utils.wrap"
utils.tab = require "zeronvim.utils.tab"
utils.nvimtree = require "zeronvim.utils.nvimtree"
utils.toggle_codeium = require "zeronvim.utils.toggle_codeium"

-- Expose Module to configuration
return utils
