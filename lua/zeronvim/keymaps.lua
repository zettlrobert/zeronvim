---- Local Utilities bound to keymaps
local utils = require "zeronvim.utils"
local folding = require "zeronvim.core.folding"
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

-- Copy to System Clipboard
-- We escape " to select the register and type + y to copy in every mode
keymap('n', '<leader>y', "\"+y")
keymap('v', '<leader>y', "\"+y")
--keymap('V', '<leader>Y', "\"+y")

-- Concatenate line
keymap("n", "J", "mzJ`z")

-- Paste without losing buffer
keymap("x", "<leader>p", "\"_dP")

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
keymap('n', '<leader>zo', folding.openFoldUnderCursor, {})
keymap('n', '<leader>zO', folding.openAllFoldsUnderCursorRecursively, {})
keymap('n', '<leader>zc', folding.closeOneFoldUnderCursor, {})
keymap('n', '<leader>zC', folding.closeAllFoldsUnderCursorRecursively, {})
keymap('n', '<leader>za', folding.openOnClosedFold, {})
keymap('n', '<leader>zA', folding.openOnClosedFoldRecursively, {})
keymap('n', '<leader>zM', folding.closeAllFolds, {})
keymap('n', '<leader>zR', folding.openAllFolds, {})
keymap('n', '<leader>zx', folding.updateFolds, {})


-- Colorpicker
keymap('n', '<leader>col', utils.colorpicker.toggle_color_picker, {})

-- Testing
local testing = function()
end
keymap('n', '<leader>test', testing, {})

-- Update Window Title
keymap('n', '<leader>titlef', utils.get_title_string.set_titlestring_to_file, {})
keymap('n', '<leader>titlep', utils.get_title_string.set_titlestring_to_project, {})

-- Toggleterm
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
