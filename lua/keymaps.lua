-- File for generic Neovim Keymaps that are not plugin specific
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Function to extend opts table with description for keymap
local set_options_and_description = function(options, desc)
  options = opts or {}
  options.desc = desc
  return options
end

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", set_options_and_description(opts, "Move Cursor to left window"))
keymap("n", "<C-j>", "<C-w>j", set_options_and_description(opts, "Move CursGo to lower window"))
keymap("n", "<C-k>", "<C-w>k", set_options_and_description(opts, "Move CursGo to upper window"))
keymap("n", "<C-l>", "<C-w>l", set_options_and_description(opts, "Move CursGo to right window"))

-- Toggle search highlight
keymap("n", "<leader>h", ":set hlsearch!<CR>", set_options_and_description(opts, "Toggle search highlight"))

-- Center cursor when paging up and down
keymap("n", "<C-d>", "<C-d>zz", set_options_and_description(opts, "Move page down and center"))
keymap("n", "<C-u>", "<C-u>zz", set_options_and_description(opts, "Move page up and center"))

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", set_options_and_description(opts, "Decrase vertical size of current window"))
keymap("n", "<C-Down>", ":resize +2<CR>", set_options_and_description(opts, "Increase vertical size of current window"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>",
  set_options_and_description(opts, "Decrase horizontal size of current window"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>",
  set_options_and_description(opts, "Increase horizontal size of current window"))

-- Manual indenting
keymap("v", "<", "<gv", set_options_and_description(opts, "Increase indentation of visual selection"))
keymap("v", ">", ">gv", set_options_and_description(opts, "Decrease indentation of visual selection"))

-- Copy to System Clipboard
-- We escape " to select the register and type + y to copy in every mode
keymap('n', '<leader>y', "\"+y",
  set_options_and_description(opts, "Copy the result of the following expression to system clipboard"))
keymap('v', '<leader>y', "\"+y", set_options_and_description(opts, "Copy visual selection to system clipboard"))

-- Concatenation
keymap("n", "J", "mzJ`z", set_options_and_description(opts, "Concatenate with line below"))

-- Paste selection without losing the current buffer
keymap("x", "<leader>p", "\"_dP", set_options_and_description(opts, "Paste without losing buffer"))

-- Move Current Lines up or down
keymap("n", "<A-k>", ":m .-2<CR>", set_options_and_description(opts, "Move current line up"))
keymap("n", "<A-j>", ":m .+1<CR>", set_options_and_description(opts, "Move current line down"))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", set_options_and_description(opts, "Move current selection up"))
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", set_options_and_description(opts, "Move current selection down"))
