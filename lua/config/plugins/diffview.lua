return {
  {
    "sindrets/diffview.nvim",
    config = function()
      local diffview = require("diffview")

      ---TODO: Configure Diffview
      diffview.setup({})

      vim.keymap.set("n", "<leader>gD", ":DiffviewOpen<CR>", { desc = "Diffview: open" })
      vim.keymap.set("n", "<leader>gC", ":DiffviewClose<CR>", { desc = "Diffview: close" })
      -- vim.keymap.set("n", "<leader>gP", ":DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle Diffview Files" })
    end,
  },
}
