return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup()

      vim.keymap.set("n", "<space>gsw", gitsigns.toggle_word_diff, { desc = "Gitsigns toggle word_diff" })
      vim.keymap.set(
        "n",
        "<space>blame",
        gitsigns.toggle_current_line_blame,
        { desc = "Gitsigns toggle_current_line_blame" }
      )
      vim.keymap.set("n", "<space>gdiff", gitsigns.diffthis, { desc = "Gitsigns diffthis" })
    end,
  },
}
