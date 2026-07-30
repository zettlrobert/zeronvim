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

-- Toggle search highlight — <leader>t namespace
keymap("n", "<leader>th", ":set hlsearch!<CR>", { desc = "Toggle: search highlight" })

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

-- Copy Buffer Paths to Registers — <leader>c namespace
keymap(
  "n",
  "<leader>cr",
  utils.get_current_realtive_buffer_path,
  { desc = "Copy: relative buffer path to r register" }
)

keymap(
  "n",
  "<leader>ca",
  utils.get_current_absolute_buffer_path,
  { desc = "Copy: absolute buffer path to a register" }
)

keymap(
  "n",
  "<leader>cA",
  utils.get_current_absolute_buffer_path_with_cwd,
  { desc = "Copy: absolute buffer path with CWD to system clipboard" }
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

-- NvimTree reveal current file in tree — <leader>e namespace (explorer)
vim.keymap.set("n", "<leader>ef", function()
  require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, { desc = "Explorer: find current file in tree" })

-- Toggles. <leader>t* is the "toggle" namespace.
-- For explicit language switching the :Spellcheck command still exists.
vim.keymap.set("n", "<leader>ts", function()
  require("config.utils").toggle_spell()
end, { desc = "Toggle spellcheck in current window" })

vim.keymap.set("n", "<leader>tv", function()
  require("config.utils").toggle_lsp_server("vale_ls")
end, { desc = "Toggle vale-ls (prose linting) in current buffer" })

-- Generic LSP server picker — toggles attach state for any configured server.
-- Replaces per-server toggles (e.g. tsgo) with a discoverable menu.
vim.keymap.set("n", "<leader>tl", function()
  require("config.utils").lsp_servers()
end, { desc = "Toggle any LSP server (picker)" })

-- LSP actions picker (categorized cheat-sheet menu over the cursor).
-- <C-.> mirrors VS Code's Quick Fix shortcut (terminal must pass it through;
-- many do, some don't). <leader>la is the always-works fallback.
local lsp_actions_picker = function()
  require("config.utils").lsp_actions()
end
vim.keymap.set({ "n", "v" }, "<C-.>", lsp_actions_picker, { desc = "LSP actions menu" })
vim.keymap.set({ "n", "v" }, "<leader>la", lsp_actions_picker, { desc = "LSP actions menu" })

-- AI (CodeCompanion) — <leader>a namespace
vim.keymap.set("n", "<leader>ac", ":CodeCompanionChat Toggle<CR>", { desc = "AI: CodeCompanion chat toggle" })
vim.keymap.set("n", "<leader>aa", ":CodeCompanionActions<CR>", { desc = "AI: CodeCompanion actions palette" })

--RenderMarkdown
vim.keymap.set(
  "n",
  "<leader>md",
  ":RenderMarkdown buf_toggle<CR>",
  { desc = ":RenderMarkdown Toggle for current buffer" }
)

-- DAP (Debug Adapter Protocol) — namespace <leader>b (b for breakpoint/bug).
-- Chose `b` because <leader>d is diagnostic float (vim.diagnostic.open_float).
local dap_bind = function(lhs, fn, desc)
  vim.keymap.set("n", lhs, function()
    require("dap")[fn]()
  end, { desc = desc })
end
dap_bind("<leader>bc", "continue", "DAP: continue / start")
dap_bind("<leader>bi", "step_into", "DAP: step into")
dap_bind("<leader>bo", "step_over", "DAP: step over")
dap_bind("<leader>bO", "step_out", "DAP: step out")
dap_bind("<leader>br", "toggle_repl", "DAP: toggle REPL")
dap_bind("<leader>bl", "run_last", "DAP: run last")
dap_bind("<leader>bx", "terminate", "DAP: terminate session (eXit)")
dap_bind("<leader>bb", "toggle_breakpoint", "DAP: toggle breakpoint")
vim.keymap.set("n", "<leader>bB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: conditional breakpoint" })
vim.keymap.set("n", "<leader>bj", function()
  require("dap").list_breakpoints()
  vim.cmd("copen")
end, { desc = "DAP: list breakpoints in quickfix" })
vim.keymap.set("n", "<leader>bw", function()
  require("dap").repl.open()
  vim.cmd([[normal! iwatch ]] .. vim.fn.input("Watch expr: "))
end, { desc = "DAP: add expression to watches" })
-- DAP UI toggles live under the toggle namespace, nested for consistency:
-- <leader>t=toggle, <leader>td=toggle-debug, <leader>tdv=view / <leader>tdu=ui
vim.keymap.set("n", "<leader>tdv", function()
  require("dap-view").toggle()
end, { desc = "Toggle: debug view (dap-view)" })
vim.keymap.set("n", "<leader>tdu", function()
  require("dapui").toggle()
end, { desc = "Toggle: debug ui (dap-ui)" })

-- Neotest — namespace <leader>T (capital to disambiguate from <leader>t toggle group).
vim.keymap.set("n", "<leader>Tt", function()
  require("neotest").run.run()
end, { desc = "Test: run nearest" })
vim.keymap.set("n", "<leader>Tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Test: run current file" })
vim.keymap.set("n", "<leader>Td", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Test: debug nearest (with DAP)" })
vim.keymap.set("n", "<leader>To", function()
  require("neotest").output.open({ enter = true })
end, { desc = "Test: open output" })
vim.keymap.set("n", "<leader>Ts", function()
  require("neotest").summary.toggle()
end, { desc = "Test: toggle summary panel" })
