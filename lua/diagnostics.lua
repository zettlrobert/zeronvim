local icons = require('icons')

-- Global Diagnostics Keybinds
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Define Signs
for _, sign in ipairs(icons.diagnostics.signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local diagnostic_config = {
  virtual_text = true,
  signs = {
    active = icons.diagnostics.signs,
  },
  source = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    border = "rounded",
    source = "always",
  }
}

vim.diagnostic.config(diagnostic_config)
