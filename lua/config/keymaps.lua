local keymap = vim.keymap.set

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move Cursor to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move CursGo to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move CursGo to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move CursGo to right window" })

-- Jump up/down and center
keymap("n", "<C-d>", "<C-d>zz", { desc = "Move page down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Move page up and center" })

-- Toggle search highlight
keymap("n", "<leader>h", ":set hlsearch!<CR>", { desc = "Toggle search highlight" })

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrase vertical size of current window" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase vertical size of current window" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrase horizontal size of current window" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase horizontal size of current window" })

-- Manual indenting
keymap("v", "<", "<gv", { desc = "Increase indentation of visual selection" })
keymap("v", ">", ">gv", { desc = "Decrease indentation of visual selection" })

-- Formatting
keymap("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", { desc = "Format the current buffer" })

-- Copy to System Clipboard
-- We escape " to select the register and type + y to copy in every mode
keymap("n", "<leader>y", '"+y', { desc = "Copy the result of the following expression to system clipboard" })
keymap("v", "<leader>y", '"+y', { desc = "Copy visual selection to system clipboard" })

-- Paste selection without losing the current buffer
keymap("x", "<leader>p", '"_dP', { desc = "Paste without losing buffer" })

-- Move Current Lines up or down
keymap("n", "<A-k>", ":m .-2<CR>", { desc = "Move current line up" })
keymap("n", "<A-j>", ":m .+1<CR>", { desc = "Move current line down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move current selection up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move current selection down" })

-- NvimTree
local nvim_tree_api = require("nvim-tree.api")

--NvimTree toggle file tree
vim.keymap.set("n", "<leader>e", function()
  nvim_tree_api.tree.toggle({
    path = "<args>",
    find_file = false,
    update_root = false,
    focus = true,
  })
end, { desc = ":NvimTree toggle filetree" })

-- NvimTree open tree and focus current file in tree
vim.keymap.set("n", "<leader>ntff", function()
  nvim_tree_api.tree.find_file({ open = true, focus = true })
end, { desc = ":NvimTree open tree and focus current file in tree" })

--Spellcheck
vim.keymap.set("n", "<leader>spell", ":Spellcheck English<cR>", { desc = ":Spellcheck English" })

vim.keymap.set("n", "<leader>spelloff", ":Spellcheck Disable<CR>", { desc = ":Spellcheck Disable" })
