local M = {}

--[[
Consistent formatter for keymap `desc` fields.

Format: `[KIND] [TOOL] description`

KIND classifies WHAT the action does (toggle, jump, pick, ...).
TOOL identifies WHICH tool provides it (plugin name for plugin actions,
category name for native vim things like Window/Motion/Line/Indent).

Usage:

  local kd = require("config.utils.keymap_desc")
  local K, T = kd.KIND, kd.TOOL

  vim.keymap.set("n", "<leader>bb", ..., {
    desc = kd.format(K.DEBUG, T.DAP, "toggle breakpoint"),
  })
  -- → "[DEBUG] [DAP] toggle breakpoint"

Both K.X and T.X return their string value, so typos error immediately
(nil indexed) instead of producing broken desc strings.
]]

M.KIND = {
  TOGGLE = "TOGGLE", -- flip state (spell, hlsearch, vale, panels)
  OPEN = "OPEN", -- open a view/window (diffview, tree)
  CLOSE = "CLOSE", -- explicit close
  RUN = "RUN", -- execute (test, format, source)
  DEBUG = "DEBUG", -- DAP operations
  JUMP = "JUMP", -- cursor movement (next/prev todo/diag/qf)
  PICK = "PICK", -- picker/menu (telescope, LSP actions)
  EDIT = "EDIT", -- modify state (rename, code action, breakpoint set)
  COPY = "COPY", -- clipboard/register copies
  PASTE = "PASTE", -- pastes
  MOVE = "MOVE", -- window/line movement
  SHOW = "SHOW", -- display info without jumping (diagnostic float, hover)
  SEARCH = "SEARCH", -- search invocations
  INDENT = "INDENT", -- indentation adjustments
}

M.TOOL = {
  -- Plugin-specific
  NvimTree = "NvimTree",
  Telescope = "Telescope",
  Diffview = "Diffview",
  Gitsigns = "Gitsigns",
  Trouble = "Trouble",
  Neotest = "Neotest",
  DAP = "DAP",
  DAPView = "dap-view",
  DAPUI = "dap-ui",
  Flash = "Flash",
  Undotree = "Undotree",
  Navbuddy = "Navbuddy",
  CodeCompanion = "CodeCompanion",
  RenderMarkdown = "RenderMarkdown",
  Oil = "Oil",
  ValeLS = "Vale-ls",
  ZenMode = "ZenMode",
  CccPick = "CccPick",
  Todo = "Todo",
  ImgClip = "img-clip",
  Kulala = "Kulala",
  MCPHub = "MCPHub",
  WhichKey = "Which-key",
  -- Native / category
  LSP = "LSP",
  Diagnostic = "Diagnostic",
  Quickfix = "Quickfix",
  Loclist = "Loclist",
  Window = "Window",
  Motion = "Motion",
  Line = "Line",
  Indent = "Indent",
  Native = "Native",
  Source = "Source",
}

---Format a keymap desc as `[KIND] [TOOL] description`.
---@param kind string One of M.KIND
---@param tool string One of M.TOOL
---@param description string Free-form action description
---@return string
function M.format(kind, tool, description)
  return string.format("[%s] [%s] %s", kind, tool, description)
end

return M
