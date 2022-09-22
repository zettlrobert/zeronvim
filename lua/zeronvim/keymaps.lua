-- Set keymap to vim.api.nvim_set_keymap function
local keymap = vim.api.nvim_set_keymap

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
