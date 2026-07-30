local utils = require("config.utils")
local keymap = vim.keymap.set
local kd = utils.keymap_desc
local K, T = kd.KIND, kd.TOOL

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", { desc = kd.format(K.MOVE, T.Window, "cursor to left") })
keymap("n", "<C-j>", "<C-w>j", { desc = kd.format(K.MOVE, T.Window, "cursor to lower") })
keymap("n", "<C-k>", "<C-w>k", { desc = kd.format(K.MOVE, T.Window, "cursor to upper") })
keymap("n", "<C-l>", "<C-w>l", { desc = kd.format(K.MOVE, T.Window, "cursor to right") })

-- Jump up/down and center
keymap("n", "<C-d>", "<C-d>zz", { desc = kd.format(K.MOVE, T.Motion, "page down (centered)") })
keymap("n", "<C-u>", "<C-u>zz", { desc = kd.format(K.MOVE, T.Motion, "page up (centered)") })

-- Toggle search highlight — <leader>t namespace
keymap("n", "<leader>th", ":set hlsearch!<CR>", { desc = kd.format(K.TOGGLE, T.Native, "search highlight") })

-- Resize Buffer with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = kd.format(K.EDIT, T.Window, "decrease vertical size") })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = kd.format(K.EDIT, T.Window, "increase vertical size") })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = kd.format(K.EDIT, T.Window, "decrease horizontal size") })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = kd.format(K.EDIT, T.Window, "increase horizontal size") })

-- Manual indenting
keymap("v", "<", "<gv", { desc = kd.format(K.INDENT, T.Native, "decrease (preserves selection)") })
keymap("v", ">", ">gv", { desc = kd.format(K.INDENT, T.Native, "increase (preserves selection)") })

-- Formatting — <leader>l namespace (lsp)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", {
  desc = kd.format(K.RUN, T.LSP, "format current buffer"),
})

-- Copy to System Clipboard
-- We escape " to select the register and type + y to copy in every mode
keymap("n", "<leader>y", '"+y', { desc = kd.format(K.COPY, T.Native, "expression result to system clipboard") })
keymap("v", "<leader>y", '"+y', { desc = kd.format(K.COPY, T.Native, "visual selection to system clipboard") })

-- Copy Buffer Paths to Registers — <leader>c namespace
keymap("n", "<leader>cr", utils.get_current_realtive_buffer_path, {
  desc = kd.format(K.COPY, T.Native, "relative buffer path to r register"),
})

keymap("n", "<leader>ca", utils.get_current_absolute_buffer_path, {
  desc = kd.format(K.COPY, T.Native, "absolute buffer path to a register"),
})

keymap("n", "<leader>cA", utils.get_current_absolute_buffer_path_with_cwd, {
  desc = kd.format(K.COPY, T.Native, "absolute buffer path with CWD to system clipboard"),
})

-- Quickfix List
keymap("n", "<A-l>", ":cnext<CR>", { desc = kd.format(K.JUMP, T.Quickfix, "next (alt binding)") })
keymap("n", "<A-h>", ":cprevious<CR>", { desc = kd.format(K.JUMP, T.Quickfix, "prev (alt binding)") })

-- Quickfix navigation (vim-unimpaired style; <A-l>/<A-h> kept as alternatives)
keymap("n", "]q", ":cnext<CR>", { desc = kd.format(K.JUMP, T.Quickfix, "next") })
keymap("n", "[q", ":cprev<CR>", { desc = kd.format(K.JUMP, T.Quickfix, "prev") })
keymap("n", "]Q", ":clast<CR>", { desc = kd.format(K.JUMP, T.Quickfix, "last") })
keymap("n", "[Q", ":cfirst<CR>", { desc = kd.format(K.JUMP, T.Quickfix, "first") })

-- Loclist navigation (mirrors quickfix)
keymap("n", "]l", ":lnext<CR>", { desc = kd.format(K.JUMP, T.Loclist, "next") })
keymap("n", "[l", ":lprev<CR>", { desc = kd.format(K.JUMP, T.Loclist, "prev") })
keymap("n", "]L", ":llast<CR>", { desc = kd.format(K.JUMP, T.Loclist, "last") })
keymap("n", "[L", ":lfirst<CR>", { desc = kd.format(K.JUMP, T.Loclist, "first") })

-- Quickfix toggle (copen / cclose)
keymap("n", "<leader>qq", function()
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end, { desc = kd.format(K.TOGGLE, T.Quickfix, "window") })

-- Quickfix populators (workspace diagnostics)
keymap("n", "<leader>qd", function()
  vim.diagnostic.setqflist()
end, { desc = kd.format(K.EDIT, T.Quickfix, "populate with all workspace diagnostics") })

keymap("n", "<leader>qe", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = kd.format(K.EDIT, T.Quickfix, "populate with workspace errors only") })

-- Paste selection without losing the current buffer
keymap("x", "<leader>p", '"_dP', { desc = kd.format(K.PASTE, T.Native, "without losing buffer") })

-- Move Current Lines up or down
keymap("n", "<A-k>", ":m .-2<CR>", { desc = kd.format(K.MOVE, T.Line, "up") })
keymap("n", "<A-j>", ":m .+1<CR>", { desc = kd.format(K.MOVE, T.Line, "down") })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = kd.format(K.MOVE, T.Line, "selection up") })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = kd.format(K.MOVE, T.Line, "selection down") })

-- NvimTree
--NvimTree toggle file tree
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle({
    find_file = false,
    update_root = false,
    focus = true,
  })
end, { desc = kd.format(K.TOGGLE, T.NvimTree, "explorer") })

-- NvimTree reveal current file in tree — <leader>e namespace (explorer)
vim.keymap.set("n", "<leader>ef", function()
  require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, { desc = kd.format(K.OPEN, T.NvimTree, "reveal current file") })

-- Toggles. <leader>t* is the "toggle" namespace.
-- For explicit language switching the :Spellcheck command still exists.
vim.keymap.set("n", "<leader>ts", function()
  require("config.utils").toggle_spell()
end, { desc = kd.format(K.TOGGLE, T.Native, "spellcheck") })

vim.keymap.set("n", "<leader>tv", function()
  require("config.utils").toggle_lsp_server("vale_ls")
end, { desc = kd.format(K.TOGGLE, T.ValeLS, "prose linting") })

-- Generic LSP server picker — toggles attach state for any configured server.
-- Replaces per-server toggles (e.g. tsgo) with a discoverable menu.
vim.keymap.set("n", "<leader>tl", function()
  require("config.utils").lsp_servers()
end, { desc = kd.format(K.PICK, T.LSP, "toggle server") })

-- LSP actions picker (categorized cheat-sheet menu over the cursor).
-- <C-.> mirrors VS Code's Quick Fix shortcut (terminal must pass it through;
-- many do, some don't). <leader>la is the always-works fallback.
local lsp_actions_picker = function()
  require("config.utils").lsp_actions()
end
vim.keymap.set({ "n", "v" }, "<C-.>", lsp_actions_picker, { desc = kd.format(K.PICK, T.LSP, "actions menu") })
vim.keymap.set({ "n", "v" }, "<leader>la", lsp_actions_picker, { desc = kd.format(K.PICK, T.LSP, "actions menu") })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = kd.format(K.EDIT, T.LSP, "rename symbol") })

-- AI (CodeCompanion) — <leader>a namespace
vim.keymap.set("n", "<leader>ac", ":CodeCompanionChat Toggle<CR>", {
  desc = kd.format(K.TOGGLE, T.CodeCompanion, "chat"),
})
vim.keymap.set("n", "<leader>aa", ":CodeCompanionActions<CR>", {
  desc = kd.format(K.PICK, T.CodeCompanion, "actions palette"),
})

-- Markdown — <leader>m namespace
vim.keymap.set("n", "<leader>mr", ":RenderMarkdown buf_toggle<CR>", {
  desc = kd.format(K.TOGGLE, T.RenderMarkdown, "render current buffer"),
})

-- DAP (Debug Adapter Protocol) — namespace <leader>b (b for breakpoint/bug).
-- Chose `b` because <leader>d is diagnostic float (vim.diagnostic.open_float).
local dap_bind = function(lhs, fn, desc)
  vim.keymap.set("n", lhs, function()
    require("dap")[fn]()
  end, { desc = desc })
end
dap_bind("<leader>bc", "continue", kd.format(K.DEBUG, T.DAP, "continue / start"))
dap_bind("<leader>bi", "step_into", kd.format(K.DEBUG, T.DAP, "step into"))
dap_bind("<leader>bo", "step_over", kd.format(K.DEBUG, T.DAP, "step over"))
dap_bind("<leader>bO", "step_out", kd.format(K.DEBUG, T.DAP, "step out"))
dap_bind("<leader>br", "toggle_repl", kd.format(K.TOGGLE, T.DAP, "REPL"))
dap_bind("<leader>bl", "run_last", kd.format(K.DEBUG, T.DAP, "run last"))
dap_bind("<leader>bx", "terminate", kd.format(K.DEBUG, T.DAP, "terminate session (eXit)"))
dap_bind("<leader>bb", "toggle_breakpoint", kd.format(K.EDIT, T.DAP, "toggle breakpoint"))
vim.keymap.set("n", "<leader>bB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = kd.format(K.EDIT, T.DAP, "conditional breakpoint") })
vim.keymap.set("n", "<leader>bj", function()
  require("dap").list_breakpoints()
  vim.cmd("copen")
end, { desc = kd.format(K.PICK, T.DAP, "list breakpoints in quickfix") })
vim.keymap.set("n", "<leader>bw", function()
  require("dap").repl.open()
  vim.cmd([[normal! iwatch ]] .. vim.fn.input("Watch expr: "))
end, { desc = kd.format(K.EDIT, T.DAP, "add expression to watches") })
-- DAP UI toggles live under the toggle namespace, nested for consistency:
-- <leader>t=toggle, <leader>td=toggle-debug, <leader>tdv=view / <leader>tdu=ui
vim.keymap.set("n", "<leader>tdv", function()
  require("dap-view").toggle()
end, { desc = kd.format(K.TOGGLE, T.DAPView, "debug panel") })
vim.keymap.set("n", "<leader>tdu", function()
  require("dapui").toggle()
end, { desc = kd.format(K.TOGGLE, T.DAPUI, "debug panels") })

-- Neotest — namespace <leader>T (capital to disambiguate from <leader>t toggle group).
vim.keymap.set("n", "<leader>Tt", function()
  require("neotest").run.run()
end, { desc = kd.format(K.RUN, T.Neotest, "nearest test") })
vim.keymap.set("n", "<leader>Tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = kd.format(K.RUN, T.Neotest, "current file") })
vim.keymap.set("n", "<leader>Td", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = kd.format(K.DEBUG, T.Neotest, "nearest test (DAP)") })
vim.keymap.set("n", "<leader>To", function()
  require("neotest").output.open({ enter = true })
end, { desc = kd.format(K.OPEN, T.Neotest, "test output") })
vim.keymap.set("n", "<leader>Ts", function()
  require("neotest").summary.toggle()
end, { desc = kd.format(K.TOGGLE, T.Neotest, "summary panel") })
