---- Local Utilities bound to keymaps
local utils = require "zeronvim.utils"

-- Set keymap to vim.api.nvim_set_keymap function
local keymap = vim.keymap.set

-- Set opts to shorten keymaps noremap, silent for no output
local opts = { noremap = true, silent = true }

-- Set terminal opts to silent
local term_opts = { silent = true }

-- Set Leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


keymap("n", "<Leader>source", utils.sourcing, opts)

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Toggle highlight
keymap("n", "<Leader>h", ":set hlsearch!<CR>", opts)

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Manual indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NVIM TREE
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
local telescope_builtin = require('telescope.builtin')
keymap('n', '<leader>ff', telescope_builtin.find_files, {})
keymap('n', '<leader>fg', telescope_builtin.live_grep, {})
keymap('n', '<leader>fb', telescope_builtin.buffers, {})
keymap('n', '<leader>fh', telescope_builtin.help_tags, {})

-- Formatting
keymap('n', '<leader>fmt', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
