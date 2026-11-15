-- https://github.com/folke/trouble.nvim
--
-- Trouble is an optional, persistent split-panel viewer over lists
-- (diagnostics, quickfix, symbols, references, todos). It does NOT replace
-- native quickfix navigation — `]q`/`[q` and `<leader>q*` (see keymaps.lua)
-- are the primary workflow. Trouble is the "examine" alternative.
--
-- All trouble bindings live under `<leader>x*` (examine) for consistency.

local kd = require("config.utils.keymap_desc")
local K, T = kd.KIND, kd.TOOL

-- Shared window opts: bottom split, 25% height
local bottom_split = {
  type = "split",
  relative = "editor",
  position = "bottom",
  size = 0.25,
}

-- Shared window opts: right split, 30% width
local right_split = {
  type = "split",
  relative = "editor",
  position = "right",
  size = 0.3,
}

---@param lhs string
---@param opts table trouble.toggle() options
---@param desc string
local function toggle(lhs, opts, desc)
  return {
    lhs,
    function()
      require("trouble").toggle(opts)
    end,
    desc = kd.format(K.OPEN, T.Trouble, desc),
  }
end

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  -- In `keys` so the maps exist from startup and load trouble on first use.
  keys = {
    -- Diagnostics
    toggle("<leader>xx", {
      mode = "diagnostics",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
    }, "workspace diagnostics panel"),
    toggle("<leader>xX", {
      mode = "diagnostics",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
      filter = { buf = 0 },
    }, "buffer diagnostics panel"),
    -- Quickfix / loclist views (don't fight native :copen / :lopen)
    toggle("<leader>xq", {
      mode = "quickfix",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
    }, "quickfix panel"),
    toggle("<leader>xl", {
      mode = "loclist",
      multiline = true,
      auto_preview = true,
      win = bottom_split,
    }, "loclist panel"),
    -- Symbols
    toggle("<leader>xs", {
      mode = "symbols",
      multiline = true,
      auto_preview = true,
      win = right_split,
    }, "symbols panel"),
    -- LSP definitions / references
    toggle("<leader>xr", {
      mode = "lsp",
      multiline = true,
      auto_preview = true,
      win = right_split,
    }, "LSP definitions + references"),
  },
  opts = {},
}
