local utils = require("config.utils")
local keymap = vim.keymap.set

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move Cursor to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move Cursor to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move Cursor to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move Cursor to right window" })

-- Jump up/down and center
keymap("n", "<C-d>", "<C-d>zz", { desc = "Move page down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Move page up and center" })

-- Toggle search highlight
keymap("n", "<leader>h", ":set hlsearch!<CR>", { desc = "Toggle search highlight" })

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease vertical size of current window" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase vertical size of current window" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease horizontal size of current window" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase horizontal size of current window" })

-- Manual indenting
keymap("v", "<", "<gv", { desc = "Decrease indentation of visual selection" })
keymap("v", ">", ">gv", { desc = "Increase indentation of visual selection" })

-- Formatting
keymap("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", { desc = "Format the current buffer" })

-- Copy to System Clipboard
-- We escape " to select the register and type + y to copy in every mode
keymap("n", "<leader>y", '"+y', { desc = "Copy the result of the following expression to system clipboard" })
keymap("v", "<leader>y", '"+y', { desc = "Copy visual selection to system clipboard" })

-- Copy Buffer Paths to Registers
keymap(
  "n",
  "<leader>cbr",
  utils.get_current_realtive_buffer_path,
  { desc = "Copy the relative path of the current buffer to the r register" }
)

keymap(
  "n",
  "<leader>car",
  utils.get_current_absolute_buffer_path,
  { desc = "Copy the absolute path of the current buffer to the a register" }
)

-- Quickfix List
keymap("n", "<A-l>", ":cnext<CR>", { desc = "Next Quickfix Item" })
keymap("n", "<A-h>", ":cprevious<CR>", { desc = "Previous Quickfix Item" })

-- Quickfix navigation (vim-unimpaired style; <A-l>/<A-h> kept as alternatives)
keymap("n", "]q", ":cnext<CR>", { desc = "Quickfix: next" })
keymap("n", "[q", ":cprev<CR>", { desc = "Quickfix: prev" })
keymap("n", "]Q", ":clast<CR>", { desc = "Quickfix: last" })
keymap("n", "[Q", ":cfirst<CR>", { desc = "Quickfix: first" })

-- Loclist navigation (mirrors quickfix)
keymap("n", "]l", ":lnext<CR>", { desc = "Loclist: next" })
keymap("n", "[l", ":lprev<CR>", { desc = "Loclist: prev" })
keymap("n", "]L", ":llast<CR>", { desc = "Loclist: last" })
keymap("n", "[L", ":lfirst<CR>", { desc = "Loclist: first" })

-- Quickfix toggle (copen / cclose)
keymap("n", "<leader>qq", function()
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end, { desc = "Quickfix: toggle window" })

-- Quickfix populators (workspace diagnostics)
keymap("n", "<leader>qd", function()
  vim.diagnostic.setqflist()
end, { desc = "Quickfix: all workspace diagnostics" })

keymap("n", "<leader>qe", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Quickfix: workspace errors only" })

-- Paste selection without losing the current buffer
keymap("x", "<leader>p", '"_dP', { desc = "Paste without losing buffer" })

-- Move Current Lines up or down
keymap("n", "<A-k>", ":m .-2<CR>", { desc = "Move current line up" })
keymap("n", "<A-j>", ":m .+1<CR>", { desc = "Move current line down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move current selection up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move current selection down" })

-- NvimTree
--NvimTree toggle file tree
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle({
    find_file = false,
    update_root = false,
    focus = true,
  })
end, { desc = ":NvimTree toggle filetree" })

-- NvimTree open tree and focus current file in tree
vim.keymap.set("n", "<leader>ntff", function()
  require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, { desc = ":NvimTree open tree and focus current file in tree" })

--Spellcheck
vim.keymap.set("n", "<leader>spell", ":Spellcheck English<CR>", { desc = ":Spellcheck English" })
vim.keymap.set("n", "<leader>spelloff", ":Spellcheck Disable<CR>", { desc = ":Spellcheck Disable" })

-- LSP toggles (per-buffer). <leader>t* is the "toggle" namespace.
vim.keymap.set("n", "<leader>tv", function()
  require("config.utils").toggle_lsp_server("vale_ls")
end, { desc = "Toggle vale-ls (prose linting) in current buffer" })

--CodeCompanion
vim.keymap.set("n", "<leader>ccc", ":CodeCompanionChat Toggle<CR>", { desc = ":CodeCompanionChat" })
vim.keymap.set("n", "<leader>action", ":CodeCompanionActions<CR>", { desc = ":CodeCompanion Action" })

--RenderMarkdown
vim.keymap.set(
  "n",
  "<leader>md",
  ":RenderMarkdown buf_toggle<CR>",
  { desc = ":RenderMarkdown Toggle for current buffer" }
)
