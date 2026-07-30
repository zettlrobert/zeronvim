return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup()

      -- <leader>g namespace (git)
      vim.keymap.set("n", "<leader>gw", gitsigns.toggle_word_diff, { desc = "Git: toggle word diff" })
      vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Git: toggle current-line blame" })
      vim.keymap.set("n", "<leader>gh", gitsigns.diffthis, { desc = "Git: hunk diff current file" })
    end,
  },
}
