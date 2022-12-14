---- Local Utilities bound to keymaps
local utils = require "zeronvim.utils"
local spelling = utils.spelling
local source_config = utils.sourcing

-- Set keymap to vim.api.nvim_set_keymap function
local keymap = vim.keymap.set

-- Set opts to shorten keymaps noremap, silent for no output
local opts = { noremap = true, silent = true }

-- Set terminal opts to silent
local term_opts = { silent = true }

-- Set leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<leader>source", source_config, {})

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Toggle highlight
keymap("n", "<leader>h", ":set hlsearch!<CR>", opts)

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Manual indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NVIM TREE
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
local telescope_builtin = require('telescope.builtin')
keymap('n', '<leader>ff', telescope_builtin.find_files, {})
keymap('n', '<leader>fg', telescope_builtin.live_grep, {})
keymap('n', '<leader>fb', telescope_builtin.buffers, {})
keymap('n', '<leader>fh', telescope_builtin.help_tags, {})

-- Formatting
keymap('n', '<leader>fmt', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)

-- Git
keymap('n', '<leader>gblame', '<cmd>:Gitsigns toggle_current_line_blame<cr>')
keymap('n', '<leader>gnum', '<cmd>:Gitsigns toggle_numhl<cr>')
keymap('n', '<leader>glh', '<cmd>:Gitsigns toggle_linehl<cr>')
keymap('n', '<leader>gwd', '<cmd>:Gitsigns toggle_word_diff<cr>')

-- Sepllchecking
keymap('n', '<leader>spell', spelling.toggle_spell_check, {})
keymap('n', '<leader>cr', spelling.add_to_dictionary, {})

-- Folding
-- TODO: Setup custom functions with fold, and notify
keymap('n', '<leader>zc', 'zc', {}) -- close one fold under cursor
keymap('n', '<leader>zC', 'zC', {}) -- close all folds under cursor recursively
keymap('n', '<leader>za', 'za', {}) -- when on closed fold, open it
keymap('n', '<leader>zA', 'zA', {}) -- when on closed fold, open it recursively
keymap('n', '<leader>zM', 'zM', {}) -- close all folds
keymap('n', '<leader>zR', 'zR', {}) -- open all folds

