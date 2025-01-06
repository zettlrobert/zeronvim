-- Execute lua code from current file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- Execute lua code from current line
vim.keymap.set("n", "<space>x", ":.lua<CR>")

-- Execute visual selection lua code
vim.keymap.set("v", "<space>x", ":lua<CR>")
