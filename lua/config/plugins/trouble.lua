-- https://github.com/folke/trouble.nvim
--
-- Trouble is an optional, persistent split-panel viewer over lists
-- (diagnostics, quickfix, symbols, references, todos). It does NOT replace
-- native quickfix navigation — `]q`/`[q` and `<leader>q*` (see keymaps.lua)
-- are the primary workflow. Trouble is the "examine" alternative.
--
-- All trouble bindings live under `<leader>x*` (examine) for consistency.

-- Keymaps: config/keymaps.lua. They require("trouble"), which loads it.

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {},
}
