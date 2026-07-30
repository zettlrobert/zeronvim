return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
      local kd = require("config.utils.keymap_desc")
      local K, T = kd.KIND, kd.TOOL

      gitsigns.setup()

      -- <leader>g namespace (git)
      vim.keymap.set("n", "<leader>gw", gitsigns.toggle_word_diff, {
        desc = kd.format(K.TOGGLE, T.Gitsigns, "word diff"),
      })
      vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, {
        desc = kd.format(K.TOGGLE, T.Gitsigns, "current-line blame"),
      })
      vim.keymap.set("n", "<leader>gh", gitsigns.diffthis, {
        desc = kd.format(K.SHOW, T.Gitsigns, "hunk diff current file"),
      })
    end,
  },
}
