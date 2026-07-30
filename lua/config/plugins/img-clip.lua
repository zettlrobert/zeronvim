--https://github.com/hakonharnes/img-clip.nvim
local kd = require("config.utils.keymap_desc")

return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
  },
  keys = {
    { "<leader>p", "<cmd>PasteImage<cr>", desc = kd.format(kd.KIND.PASTE, kd.TOOL.ImgClip, "image from clipboard") },
  },
}
