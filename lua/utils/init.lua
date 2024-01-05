local telescope_builtin = require('telescope.builtin')

local M = {}

M.telescope_find_env = function()
  telescope_builtin.find_files({ no_ignore = true })
end

M.telescope_builtin = telescope_builtin

return M
