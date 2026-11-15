return {
  {
    "lewis6991/gitsigns.nvim",
    -- Loads with the first real file buffer. The <leader>g keymaps in
    -- config/keymaps.lua also load it through require("gitsigns").
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = "Gitsigns",
    opts = {},
  },
}
