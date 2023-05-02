---- Local Utilities bound to Keymaps
local utils = require "zeronvim.utils"
local folding = require "zeronvim.core.folding"
local telescope = require "zeronvim.plugins.telescope"
local todo_comments = require "zeronvim.plugins.todo-comments"
local spelling = utils.spelling
local tab = utils.tab
local source_config = utils.sourcing

-- Set keymap to vim.api.nvim_set_keymap function
local keymap = vim.keymap.set

-- Set opts to shorten keymaps noremap, silent for no output
local opts = { noremap = true, silent = true }

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
keymap("n", "<C-t>", tab.tabnew, {})
keymap("n", "<C-q>", tab.tabclose, {})
keymap("n", "<leader>ntff", utils.nvimtree.nvim_tree_find_file, {})

-- Toggle highlight
keymap("n", "<leader>h", ":set hlsearch!<CR>", opts)

-- Keep Cursor centered when going page up and down
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

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

-- Move Current Lines up or down
keymap("n", "<A-k>", ":m .-2<CR>", opts)
keymap("n", "<A-j>", ":m .+1<CR>", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)

-- NVIM TREE
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
local telescope_builtin = require('telescope.builtin')
keymap('n', '<leader>ff', telescope_builtin.find_files, {})
keymap('n', '<leader>fy', telescope.find_env, {})
keymap('n', '<leader>fg', telescope_builtin.live_grep, {})
keymap('n', '<leader>fb', telescope_builtin.buffers, {})
keymap('n', '<leader>fh', telescope_builtin.help_tags, {})
keymap('n', '<leader>key', telescope_builtin.keymaps, {})

-- Formatting
keymap('n', '<leader>fmt', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)

-- Git
keymap('n', '<leader>gblame', '<cmd>:Gitsigns toggle_current_line_blame<cr>')
keymap('n', '<leader>gnum', '<cmd>:Gitsigns toggle_numhl<cr>')
keymap('n', '<leader>glh', '<cmd>:Gitsigns toggle_linehl<cr>')
keymap('n', '<leader>gwd', '<cmd>:Gitsigns toggle_word_diff<cr>')

-- AI
keymap('n', '<leader>tai', utils.toggle_codeium.toggle_ai, {})
keymap('n', '<leader>taitrace', utils.toggle_codeium.toggle_codium_logging, {})
keymap('n', '<leader>tailog', utils.toggle_codeium.open_codium_log, {})

-- Spellchecking
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

-- Line Wrapping
keymap('n', '<leader>wrap', utils.wrap.toggle_wrap, {})

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, desc = "Toggle Trouble" })
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  { silent = true, desc = "Toggle Trouble Workspace Diagnostics" })
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  { silent = true, desc = "Toggle Trouble Docuemnt Diagnostics" })
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  { silent = true, desc = "Toggle Trouble Location List" })
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  { silent = true, desc = "Toggle Trouble Quickfix List" })
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  { silent = true, desc = "Toggle Trouble LSP References" })
keymap("n", "<leader>todo", "<cmd>TodoQuickFix<cr>", { silent = true, desc = "Project wide todos" })
keymap("n", "<leader>to", "<cmd>TodoTrouble<cr>", { silent = true, desc = "Trouble Project wide todos" })
keymap("n", "<leader>todol", "<cmd>TodoLocList<cr>", { silent = true, desc = "File wide todos" })
keymap("n", "]t", todo_comments.todo_comments.jump_next, { silent = true, desc = "Next todo comment" })
keymap("n", "[t", todo_comments.todo_comments.jump_prev, { silent = true, desc = "Previous todo comment" })

-- Toggleterm
function _G.set_terminal_keymaps()
  local term_opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], term_opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], term_opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], term_opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], term_opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], term_opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], term_opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
