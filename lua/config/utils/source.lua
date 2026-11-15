local keymap_desc = require("config.utils.keymap_desc")
local KIND, TOOL = keymap_desc.KIND, keymap_desc.TOOL

-- Execute lua code from current file
vim.keymap.set("n", "<leader><leader>x", function()
  vim.api.nvim_command("source %")

  vim.notify("Executed current file via lua", vim.log.levels.INFO)
end, { desc = keymap_desc.format(KIND.RUN, TOOL.Source, "execute current file") })

-- Execute lua code from current line
vim.keymap.set("n", "<leader>x", function()
  vim.cmd(":.lua")

  vim.notify("Executed current line via lua", vim.log.levels.INFO)
end, { desc = keymap_desc.format(KIND.RUN, TOOL.Source, "execute current line") })

-- Execute visual selection lua code. A callback replaces the rhs, so the
-- old ":lua<CR>" rhs never ran. Leave Visual mode first so '< and '> mark
-- this selection, then run it.
vim.keymap.set("v", "<leader>x", function()
  vim.cmd("normal! \27")
  vim.cmd("'<,'>lua")

  vim.notify("Executed current selection via lua", vim.log.levels.INFO)
end, { desc = keymap_desc.format(KIND.RUN, TOOL.Source, "execute selection") })
