local utils = require "zeronvim.utils"
local telescope = utils.protected_plugin_call("nvim-tree")

if telescope then
  telescope.setup({
    pickers = {
      find_files = {
        theme = "ivy"
      }
    }
  })
end
