return {
  {
    "sindrets/diffview.nvim",
    config = function()
      local diffview = require("diffview")

      ---TODO: Configure Diffview
      diffview.setup({})

      vim.keymap.set("n", "<leader>gD", ":DiffviewOpen<CR>", { desc = "Diffview: Open Diffview" })
      vim.keymap.set("n", "<leader>gC", ":DiffviewClose<CR>", { desc = "Diffview: Close Diffview" })
      -- vim.keymap.set("n", "<leader>gP", ":DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle Diffview Files" })
    end,
  },
}
