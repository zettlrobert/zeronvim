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
  config = function(_, opts)
    require("persistence").setup(opts)

    local kd = require("config.utils.keymap_desc")
    local K, T = kd.KIND, kd.TOOL

    -- <leader>P namespace (persistence)
    vim.keymap.set("n", "<leader>Ps", function()
      require("persistence").load()
    end, { desc = kd.format(K.OPEN, T.Persistence, "restore session for cwd") })

    vim.keymap.set("n", "<leader>Pl", function()
      require("persistence").load({ last = true })
    end, { desc = kd.format(K.OPEN, T.Persistence, "restore last session (any cwd)") })

    vim.keymap.set("n", "<leader>Pd", function()
      require("persistence").stop()
    end, { desc = kd.format(K.TOGGLE, T.Persistence, "stop autosave for this session") })
  end,
}
