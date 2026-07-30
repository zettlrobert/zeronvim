return {
  {
    "sindrets/diffview.nvim",
    config = function()
      local diffview = require("diffview")
      local kd = require("config.utils.keymap_desc")
      local K, T = kd.KIND, kd.TOOL

      ---TODO: Configure Diffview
      diffview.setup({})

      vim.keymap.set("n", "<leader>gD", ":DiffviewOpen<CR>", { desc = kd.format(K.OPEN, T.Diffview, "diff view") })
      vim.keymap.set("n", "<leader>gC", ":DiffviewClose<CR>", { desc = kd.format(K.CLOSE, T.Diffview, "diff view") })
      -- vim.keymap.set("n", "<leader>gP", ":DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle Diffview Files" })
    end,
  },
}
