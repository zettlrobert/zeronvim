local utils = require "zeronvim.utils"
local indent_blanklines = utils.protected_plugin_call("indent_blankline")

vim.opt.list = true
vim.opt.listchars:append "eol:↴"

if indent_blanklines then
  indent_blanklines.setup({
    filetype_exclude = { "NvimTree" },
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true
  })
end
