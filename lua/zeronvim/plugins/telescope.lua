local utils = require "zeronvim.utils"
local telescope = utils.protected_plugin_call("telescope")
local telescope_builtin = utils.protected_plugin_call("telescope.builtin")
local M = {}

if telescope then
  telescope.setup {
    defaults = {
      path_display = { "smart" },
    },
    pickers = {
      find_files = {
        find_command = {'rg' ,'--hidden','--files' },
      }
    }
  }
end

M.find_env = function()
  if telescope_builtin then
    telescope_builtin.find_files({no_ignore=true})
  end
end

return M
