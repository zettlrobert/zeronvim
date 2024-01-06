local keymap = vim.keymap.set

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move Cursor to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move CursGo to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move CursGo to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move CursGo to right window" })

-- Toggle search highlight
keymap("n", "<leader>h", ":set hlsearch!<CR>", { desc = "Toggle search highlight" })

-- Center cursor when paging up and down
keymap("n", "<C-d>", "<C-d>zz", { desc = "Move page down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Move page up and center" })

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrase vertical size of current window" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase vertical size of current window" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>",
  { desc = "Decrase horizontal size of current window" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>",
  { desc = "Increase horizontal size of current window" })

-- Manual indenting
keymap("v", "<", "<gv", { desc = "Increase indentation of visual selection" })
keymap("v", ">", ">gv", { desc = "Decrease indentation of visual selection" })

-- Copy to System Clipboard
-- We escape " to select the register and type + y to copy in every mode
keymap('n', '<leader>y', "\"+y",
  { desc = "Copy the result of the following expression to system clipboard" })
keymap('v', '<leader>y', "\"+y", { desc = "Copy visual selection to system clipboard" })

-- Concatenation
keymap("n", "J", "mzJ`z", { desc = "Concatenate with line below" })

-- Paste selection without losing the current buffer
keymap("x", "<leader>p", "\"_dP", { desc = "Paste without losing buffer" })

-- Move Current Lines up or down
keymap("n", "<A-k>", ":m .-2<CR>", { desc = "Move current line up" })
keymap("n", "<A-j>", ":m .+1<CR>", { desc = "Move current line down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move current selection up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move current selection down" })

-- LSP
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to References" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Execute Code Action" })
