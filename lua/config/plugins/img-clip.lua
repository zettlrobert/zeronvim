--https://github.com/hakonharnes/img-clip.nvim
return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
  },
  keys = {
    -- suggested keymap
    { "<leader>p", "<cmd>PasteImage<cr>", desc = ":img-clip Paste image from system clipboard" },
  },
}
