local utils = require("config.utils")
local keymap = vim.keymap.set
local keymap_desc = utils.keymap_desc
local KIND, TOOL = keymap_desc.KIND, keymap_desc.TOOL

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", { desc = keymap_desc.format(KIND.MOVE, TOOL.Window, "cursor to left") })
keymap("n", "<C-j>", "<C-w>j", { desc = keymap_desc.format(KIND.MOVE, TOOL.Window, "cursor to lower") })
keymap("n", "<C-k>", "<C-w>k", { desc = keymap_desc.format(KIND.MOVE, TOOL.Window, "cursor to upper") })
keymap("n", "<C-l>", "<C-w>l", { desc = keymap_desc.format(KIND.MOVE, TOOL.Window, "cursor to right") })

-- Jump up/down and center
keymap("n", "<C-d>", "<C-d>zz", { desc = keymap_desc.format(KIND.MOVE, TOOL.Motion, "page down (centered)") })
keymap("n", "<C-u>", "<C-u>zz", { desc = keymap_desc.format(KIND.MOVE, TOOL.Motion, "page up (centered)") })

-- Toggle search highlight — <leader>t namespace
keymap(
  "n",
  "<leader>th",
  "<cmd>set hlsearch!<CR>",
  { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Native, "search highlight") }
)

-- Resize Buffer with arrow keys
keymap(
  "n",
  "<C-Up>",
  "<cmd>resize -2<CR>",
  { desc = keymap_desc.format(KIND.EDIT, TOOL.Window, "decrease vertical size") }
)
keymap(
  "n",
  "<C-Down>",
  "<cmd>resize +2<CR>",
  { desc = keymap_desc.format(KIND.EDIT, TOOL.Window, "increase vertical size") }
)
keymap(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<CR>",
  { desc = keymap_desc.format(KIND.EDIT, TOOL.Window, "decrease horizontal size") }
)
keymap(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<CR>",
  { desc = keymap_desc.format(KIND.EDIT, TOOL.Window, "increase horizontal size") }
)

-- Manual indenting
keymap("v", "<", "<gv", { desc = keymap_desc.format(KIND.INDENT, TOOL.Native, "decrease (preserves selection)") })
keymap("v", ">", ">gv", { desc = keymap_desc.format(KIND.INDENT, TOOL.Native, "increase (preserves selection)") })

-- Formatting — <leader>l namespace (lsp). Same formatters as format-on-save
-- (lua/config/plugins/conform.lua): conform first, LSP only as a fallback, and
-- no LSP fallback for markdown and yaml.
keymap("n", "<leader>lf", function()
  local filetype = vim.bo.filetype
  local lsp_format = (filetype == "markdown" or filetype == "yaml") and "never" or "fallback"
  require("conform").format({ async = true, lsp_format = lsp_format })
end, {
  desc = keymap_desc.format(KIND.RUN, TOOL.LSP, "format current buffer"),
})

-- Copy to System Clipboard
-- We escape " to select the register and type + y to copy in every mode
keymap(
  "n",
  "<leader>y",
  '"+y',
  { desc = keymap_desc.format(KIND.COPY, TOOL.Native, "expression result to system clipboard") }
)
keymap(
  "v",
  "<leader>y",
  '"+y',
  { desc = keymap_desc.format(KIND.COPY, TOOL.Native, "visual selection to system clipboard") }
)

-- Copy Buffer Paths to Registers — <leader>c namespace
keymap("n", "<leader>cr", utils.copy_path.copy_relative, {
  desc = keymap_desc.format(KIND.COPY, TOOL.Native, "relative buffer path to r register"),
})

keymap("n", "<leader>ca", utils.copy_path.copy_absolute, {
  desc = keymap_desc.format(KIND.COPY, TOOL.Native, "absolute buffer path to a register"),
})

keymap("n", "<leader>cA", utils.copy_path.copy_absolute_clipboard, {
  desc = keymap_desc.format(KIND.COPY, TOOL.Native, "absolute buffer path with CWD to system clipboard"),
})

-- Quickfix List
keymap("n", "<A-l>", "<cmd>cnext<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Quickfix, "next (alt binding)") })
keymap(
  "n",
  "<A-h>",
  "<cmd>cprevious<CR>",
  { desc = keymap_desc.format(KIND.JUMP, TOOL.Quickfix, "prev (alt binding)") }
)

-- Quickfix navigation (vim-unimpaired style; <A-l>/<A-h> kept as alternatives)
keymap("n", "]q", "<cmd>cnext<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Quickfix, "next") })
keymap("n", "[q", "<cmd>cprev<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Quickfix, "prev") })
keymap("n", "]Q", "<cmd>clast<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Quickfix, "last") })
keymap("n", "[Q", "<cmd>cfirst<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Quickfix, "first") })

-- Loclist navigation (mirrors quickfix)
keymap("n", "]l", "<cmd>lnext<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Loclist, "next") })
keymap("n", "[l", "<cmd>lprev<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Loclist, "prev") })
keymap("n", "]L", "<cmd>llast<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Loclist, "last") })
keymap("n", "[L", "<cmd>lfirst<CR>", { desc = keymap_desc.format(KIND.JUMP, TOOL.Loclist, "first") })

-- Quickfix toggle (copen / cclose)
keymap("n", "<leader>qq", function()
  for _, window in ipairs(vim.fn.getwininfo()) do
    if window.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Quickfix, "window") })

-- Quickfix populators (workspace diagnostics)
keymap("n", "<leader>qd", function()
  vim.diagnostic.setqflist()
end, { desc = keymap_desc.format(KIND.EDIT, TOOL.Quickfix, "populate with all workspace diagnostics") })

keymap("n", "<leader>qe", function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = keymap_desc.format(KIND.EDIT, TOOL.Quickfix, "populate with workspace errors only") })

-- Clear the qf list without closing its window. Useful when building a new
-- set of entries via telescope `<C-a>` (append) after a prior collection.
keymap("n", "<leader>qc", function()
  vim.fn.setqflist({}, "r")
end, { desc = keymap_desc.format(KIND.EDIT, TOOL.Quickfix, "clear list") })

-- Paste selection without losing the current buffer
keymap("x", "<leader>p", '"_dP', { desc = keymap_desc.format(KIND.PASTE, TOOL.Native, "without losing buffer") })

-- Move Current Lines up or down
keymap("n", "<A-k>", "<cmd>m .-2<CR>", { desc = keymap_desc.format(KIND.MOVE, TOOL.Line, "up") })
keymap("n", "<A-j>", "<cmd>m .+1<CR>", { desc = keymap_desc.format(KIND.MOVE, TOOL.Line, "down") })
-- Visual moves keep ":" (the command needs the '<,'> range); silent hides the echo.
keymap(
  "v",
  "<A-k>",
  ":m '<-2<CR>gv=gv",
  { silent = true, desc = keymap_desc.format(KIND.MOVE, TOOL.Line, "selection up") }
)
keymap(
  "v",
  "<A-j>",
  ":m '>+1<CR>gv=gv",
  { silent = true, desc = keymap_desc.format(KIND.MOVE, TOOL.Line, "selection down") }
)

-- NvimTree
--NvimTree toggle file tree
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle({
    find_file = false,
    update_root = false,
    focus = true,
  })
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.NvimTree, "explorer") })

-- NvimTree reveal current file in tree — <leader>e namespace (explorer)
vim.keymap.set("n", "<leader>ef", function()
  require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.NvimTree, "reveal current file") })

-- Telescope — <leader>f namespace (find). Each map requires telescope, which
-- loads the lazy plugin on first use.
local telescope_pick = function(picker, opts)
  return function()
    require("telescope.builtin")[picker](opts)
  end
end
keymap(
  "n",
  "<leader>fh",
  telescope_pick("help_tags"),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "help tags") }
)
keymap(
  "n",
  "<leader>ff",
  telescope_pick("find_files"),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "files") }
)
keymap(
  "n",
  "<leader>f.",
  telescope_pick("find_files", {
    find_command = { "rg", "--hidden", "--files" },
    theme = "ivy",
  }),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "files (including hidden)") }
)
keymap(
  "n",
  "<leader>fb",
  telescope_pick("buffers"),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "buffers") }
)
keymap(
  "n",
  "<leader>fl",
  telescope_pick("live_grep"),
  { desc = keymap_desc.format(KIND.SEARCH, TOOL.Telescope, "live grep") }
)
keymap("n", "<leader>fg", function()
  require("config.plugins.telescope.multigrep").live_multigrep()
end, { desc = keymap_desc.format(KIND.SEARCH, TOOL.Telescope, "multigrep (double-space separates glob)") })
-- LSP pickers (results can be sent to qflist via <C-q> inside the picker)
keymap(
  "n",
  "<leader>fr",
  telescope_pick("lsp_references"),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "LSP references") }
)
keymap(
  "n",
  "<leader>fd",
  telescope_pick("lsp_definitions"),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "LSP definitions") }
)
keymap(
  "n",
  "<leader>fD",
  telescope_pick("diagnostics"),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "diagnostics") }
)
-- Keymap picker (complements which-key: search by desc)
keymap(
  "n",
  "<leader>fk",
  telescope_pick("keymaps"),
  { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "keymaps") }
)
keymap("n", "<leader>fn", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "nvim config files") })
keymap("n", "<leader>fp", function()
  require("telescope.builtin").find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end, { desc = keymap_desc.format(KIND.PICK, TOOL.Telescope, "installed plugin files") })

-- Snacks. Show the notifier's toast history. Useful when a notification faded
-- before you could read it, or to see errors from plugins that route through
-- vim.notify (e.g. minuet completion failures).
keymap("n", "<leader>nh", function()
  require("snacks").notifier.show_history()
end, { desc = keymap_desc.format(KIND.SHOW, TOOL.Notifier, "notification history") })

-- Scratch buffers. `<leader>.` opens/toggles the primary scratch for this cwd
-- (markdown by default). `<leader>S` opens the picker over all scratches for
-- this cwd, to jump between multiple ongoing notes.
keymap("n", "<leader>.", function()
  require("snacks").scratch()
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Scratch, "new scratch buffer") })
keymap("n", "<leader>S", function()
  require("snacks").scratch.select()
end, { desc = keymap_desc.format(KIND.PICK, TOOL.Scratch, "select scratch buffer") })

-- Persistence — <leader>P namespace (sessions)
keymap("n", "<leader>Ps", function()
  require("persistence").load()
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Persistence, "restore session for cwd") })
keymap("n", "<leader>Pl", function()
  require("persistence").load({ last = true })
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Persistence, "restore last session (any cwd)") })
keymap("n", "<leader>Pd", function()
  require("persistence").stop()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Persistence, "stop autosave for this session") })

-- Git — <leader>g namespace (gitsigns, diffview)
keymap("n", "<leader>gw", function()
  require("gitsigns").toggle_word_diff()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Gitsigns, "word diff") })
keymap("n", "<leader>gb", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Gitsigns, "current-line blame") })
keymap("n", "<leader>gh", function()
  require("gitsigns").diffthis()
end, { desc = keymap_desc.format(KIND.SHOW, TOOL.Gitsigns, "hunk diff current file") })
keymap("n", "<leader>gD", "<cmd>DiffviewOpen<CR>", { desc = keymap_desc.format(KIND.OPEN, TOOL.Diffview, "diff view") })
keymap(
  "n",
  "<leader>gC",
  "<cmd>DiffviewClose<CR>",
  { desc = keymap_desc.format(KIND.CLOSE, TOOL.Diffview, "diff view") }
)
-- keymap("n", "<leader>gP", "<cmd>DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle Diffview Files" })

-- Trouble — <leader>x namespace (examine). An optional, persistent split
-- panel over lists (diagnostics, quickfix, symbols, references, todos). It does
-- NOT replace native quickfix navigation: `]q`/`[q` and `<leader>q*` above are
-- the primary workflow.
local trouble_bottom = { type = "split", relative = "editor", position = "bottom", size = 0.25 }
local trouble_right = { type = "split", relative = "editor", position = "right", size = 0.3 }
---@param lhs string
---@param opts table trouble.toggle() options
---@param desc string
local trouble_toggle = function(lhs, opts, desc)
  keymap("n", lhs, function()
    require("trouble").toggle(opts)
  end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Trouble, desc) })
end
trouble_toggle("<leader>xx", {
  mode = "diagnostics",
  multiline = true,
  auto_preview = true,
  win = trouble_bottom,
}, "workspace diagnostics panel")
trouble_toggle("<leader>xX", {
  mode = "diagnostics",
  multiline = true,
  auto_preview = true,
  win = trouble_bottom,
  filter = { buf = 0 },
}, "buffer diagnostics panel")
-- Quickfix / loclist views (don't fight native :copen / :lopen)
trouble_toggle("<leader>xq", {
  mode = "quickfix",
  multiline = true,
  auto_preview = true,
  win = trouble_bottom,
}, "quickfix panel")
trouble_toggle("<leader>xl", {
  mode = "loclist",
  multiline = true,
  auto_preview = true,
  win = trouble_bottom,
}, "loclist panel")
trouble_toggle("<leader>xs", {
  mode = "symbols",
  multiline = true,
  auto_preview = true,
  win = trouble_right,
}, "symbols panel")
trouble_toggle("<leader>xr", {
  mode = "lsp",
  multiline = true,
  auto_preview = true,
  win = trouble_right,
}, "LSP definitions + references")
-- The todo source ships with todo-comments: load it first in case no file
-- buffer has loaded it yet.
keymap("n", "<leader>xt", function()
  require("todo-comments")
  require("trouble").toggle({ mode = "todo" })
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Trouble, "todos panel") })

-- TODO comments. ]t/[t override the built-in :tnext/:tprevious on purpose
-- (]TOOL/[TOOL and the :tnext command still work).
keymap("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = keymap_desc.format(KIND.JUMP, TOOL.Todo, "next comment") })
keymap("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = keymap_desc.format(KIND.JUMP, TOOL.Todo, "previous comment") })

-- Undo history panel
keymap("n", "<leader>u", function()
  require("undotree").toggle()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Undotree, "undo history panel") })

-- Oil (directory buffer editing)
keymap("n", "-", "<cmd>Oil<CR>", { desc = keymap_desc.format(KIND.OPEN, TOOL.Oil, "parent directory") })
keymap("n", "<leader>-", function()
  require("oil").toggle_float()
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Oil, "parent directory (float)") })

-- Symbols — <leader>s namespace (room for future <leader>sd/sw)
keymap("n", "<leader>ss", function()
  require("nvim-navbuddy").open()
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Navbuddy, "symbol tree") })

-- Flash: hint-based motions (`s`), treesitter selection (`S`), remote
-- operator (`r`), and labels in cmdline search (`<C-s>`).
keymap({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = keymap_desc.format(KIND.JUMP, TOOL.Flash, "hint-based") })
keymap({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = keymap_desc.format(KIND.JUMP, TOOL.Flash, "treesitter node") })
keymap("o", "r", function()
  require("flash").remote()
end, { desc = keymap_desc.format(KIND.JUMP, TOOL.Flash, "remote (operator)") })
keymap({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = keymap_desc.format(KIND.SEARCH, TOOL.Flash, "treesitter") })
keymap("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Flash, "in cmdline search") })

-- Paste an image from the clipboard (img-clip)
keymap(
  "n",
  "<leader>p",
  "<cmd>PasteImage<cr>",
  { desc = keymap_desc.format(KIND.PASTE, TOOL.ImgClip, "image from clipboard") }
)

-- Which-key: buffer-local keymaps only
keymap("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = keymap_desc.format(KIND.SHOW, TOOL.WhichKey, "buffer-local keymaps") })

-- Toggles. <leader>t* is the "toggle" namespace.
-- For explicit language switching the :Spellcheck command still exists.
vim.keymap.set("n", "<leader>ts", function()
  require("config.utils").toggle_spell()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Native, "spellcheck") })

vim.keymap.set("n", "<leader>tm", function()
  require("config.utils.toggle_linter").toggle("markdownlint-cli2")
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Markdownlint, "linter") })

vim.keymap.set(
  "n",
  "<leader>tc",
  "<cmd>CccPick<CR>",
  { desc = keymap_desc.format(KIND.OPEN, TOOL.CccPick, "color picker") }
)

vim.keymap.set("n", "<leader>tz", function()
  require("zen-mode").toggle({
    plugins = {
      twilight = { enabled = false },
      gitsigns = { enabled = true },
    },
  })
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.ZenMode, "distraction-free mode") })

vim.keymap.set("n", "<leader>tv", function()
  require("config.utils").toggle_lsp_server("vale_ls")
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.ValeLS, "prose linting") })

-- Generic LSP server picker — toggles attach state for any configured server.
-- Replaces per-server toggles with a discoverable menu.
vim.keymap.set("n", "<leader>tl", function()
  require("config.utils").lsp_servers()
end, { desc = keymap_desc.format(KIND.PICK, TOOL.LSP, "toggle server") })

-- LSP actions picker (categorized cheat-sheet menu over the cursor).
-- <C-.> mirrors VS Code's Quick Fix shortcut (terminal must pass it through;
-- many do, some don't). <leader>la is the always-works fallback.
local lsp_actions_picker = function()
  require("config.utils").lsp_actions()
end
vim.keymap.set(
  { "n", "v" },
  "<C-.>",
  lsp_actions_picker,
  { desc = keymap_desc.format(KIND.PICK, TOOL.LSP, "actions menu") }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>la",
  lsp_actions_picker,
  { desc = keymap_desc.format(KIND.PICK, TOOL.LSP, "actions menu") }
)
vim.keymap.set(
  "n",
  "<leader>lr",
  vim.lsp.buf.rename,
  { desc = keymap_desc.format(KIND.EDIT, TOOL.LSP, "rename symbol") }
)

-- AI — <leader>a namespace (CodeCompanion + Copilot/Minuet toggles).
-- The provider plugins are lazy; ai_toggle loads each one on first enable.
vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", {
  desc = keymap_desc.format(KIND.TOGGLE, TOOL.CodeCompanion, "chat"),
})
vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<CR>", {
  desc = keymap_desc.format(KIND.PICK, TOOL.CodeCompanion, "actions palette"),
})
vim.keymap.set("n", "<leader>aA", function()
  require("config.utils.ai_toggle").toggle_all()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.AI, "all providers (copilot + minuet)") })
vim.keymap.set("n", "<leader>ap", function()
  require("config.utils.ai_toggle").toggle_copilot()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Copilot, "AI suggestions") })
vim.keymap.set("n", "<leader>am", function()
  require("config.utils.ai_toggle").toggle_minuet()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Minuet, "local AI completion") })

-- Markdown — <leader>m namespace
vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown buf_toggle<CR>", {
  desc = keymap_desc.format(KIND.TOGGLE, TOOL.RenderMarkdown, "render current buffer"),
})

-- DAP (Debug Adapter Protocol) — namespace <leader>b (b for breakpoint/bug).
-- Chose `b` because <leader>d is diagnostic float (vim.diagnostic.open_float).
local dap_bind = function(lhs, method, desc)
  vim.keymap.set("n", lhs, function()
    require("dap")[method]()
  end, { desc = desc })
end
dap_bind("<leader>bc", "continue", keymap_desc.format(KIND.DEBUG, TOOL.DAP, "continue / start"))
dap_bind("<leader>bi", "step_into", keymap_desc.format(KIND.DEBUG, TOOL.DAP, "step into"))
dap_bind("<leader>bo", "step_over", keymap_desc.format(KIND.DEBUG, TOOL.DAP, "step over"))
dap_bind("<leader>bO", "step_out", keymap_desc.format(KIND.DEBUG, TOOL.DAP, "step out"))
dap_bind("<leader>br", "toggle_repl", keymap_desc.format(KIND.TOGGLE, TOOL.DAP, "REPL"))
dap_bind("<leader>bl", "run_last", keymap_desc.format(KIND.DEBUG, TOOL.DAP, "run last"))
dap_bind("<leader>bx", "terminate", keymap_desc.format(KIND.DEBUG, TOOL.DAP, "terminate session (eXit)"))
dap_bind("<leader>bb", "toggle_breakpoint", keymap_desc.format(KIND.EDIT, TOOL.DAP, "toggle breakpoint"))
vim.keymap.set("n", "<leader>bB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = keymap_desc.format(KIND.EDIT, TOOL.DAP, "conditional breakpoint") })
vim.keymap.set("n", "<leader>bj", function()
  require("dap").list_breakpoints()
  vim.cmd("copen")
end, { desc = keymap_desc.format(KIND.PICK, TOOL.DAP, "list breakpoints in quickfix") })
vim.keymap.set("n", "<leader>bw", function()
  require("dap").repl.open()
  vim.cmd([[normal! iwatch ]] .. vim.fn.input("Watch expr: "))
end, { desc = keymap_desc.format(KIND.EDIT, TOOL.DAP, "add expression to watches") })
-- DAP UI toggles live under the toggle namespace, nested for consistency:
-- <leader>t=toggle, <leader>td=toggle-debug, <leader>tdv=view / <leader>tdu=ui
vim.keymap.set("n", "<leader>tdv", function()
  require("dap-view").toggle()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.DAPView, "debug panel") })
vim.keymap.set("n", "<leader>tdu", function()
  require("dapui").toggle()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.DAPUI, "debug panels") })

-- Neotest — namespace <leader>TOOL (capital to disambiguate from <leader>t toggle group).
vim.keymap.set("n", "<leader>Tt", function()
  require("neotest").run.run()
end, { desc = keymap_desc.format(KIND.RUN, TOOL.Neotest, "nearest test") })
vim.keymap.set("n", "<leader>Tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = keymap_desc.format(KIND.RUN, TOOL.Neotest, "current file") })
vim.keymap.set("n", "<leader>Td", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = keymap_desc.format(KIND.DEBUG, TOOL.Neotest, "nearest test (DAP)") })
vim.keymap.set("n", "<leader>To", function()
  require("neotest").output.open({ enter = true })
end, { desc = keymap_desc.format(KIND.OPEN, TOOL.Neotest, "test output") })
vim.keymap.set("n", "<leader>Ts", function()
  require("neotest").summary.toggle()
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.Neotest, "summary panel") })
