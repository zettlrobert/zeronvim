-- Set keymap to vim.api.nvim_set_keymap function
local keymap = vim.keymap.set

-- Set opts to shorten keymaps noremap, silent for no output
local opts =  { noremap = true, silent = true }

-- Set terminal opts to silent
local term_opts = { silent = true }

-- Set Leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reload Configuration
keymap("n", "<Leader>sv", "<cmd>lua require'zeronvim.utils.sourcing'.source_nvim_configuration()<CR>", opts)

-- Window Navigation
keymap("n", "<C->h", "<C-w>h", opts)
keymap("n", "<C->j", "<C-w>j", opts)
keymap("n", "<C->k", "<C-w>k", opts)
keymap("n", "<C->l", "<C-w>l", opts)

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
