local utils = require "zeronvim.utils"
local ccc = utils.protected_plugin_call("ccc")

-- This Auto Command Toggles the CccHighligher when we enter and leave a buffer
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWinLeave" }, {
  callback = function()
    vim.api.nvim_command('CccHighlighterToggle')
  end
})

if ccc then
  ccc.setup({})
end
