-- https://github.com/folke/persistence.nvim
--
-- Per-cwd session persistence. Saves the current session (open buffers,
-- windows, tabs, current position) to disk on VimLeavePre; restore is
-- opt-in via `<leader>Ps` so opening `nvim .` doesn't surprise you with an
-- unexpected buffer set.
--
-- Sessions live under `~/.local/share/nvim/sessions/` — one file per cwd
-- (path is the encoded absolute path).

return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
}
