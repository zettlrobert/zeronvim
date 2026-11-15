-- https://github.com/sindrets/diffview.nvim
local kd = require("config.utils.keymap_desc")
local K, T = kd.KIND, kd.TOOL

return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
      "DiffviewLog",
    },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<CR>", desc = kd.format(K.OPEN, T.Diffview, "diff view") },
      { "<leader>gC", "<cmd>DiffviewClose<CR>", desc = kd.format(K.CLOSE, T.Diffview, "diff view") },
      -- { "<leader>gP", "<cmd>DiffviewToggleFiles<CR>", desc = "Diffview: Toggle Diffview Files" },
    },
    ---TODO: Configure Diffview
    opts = {},
  },
}
