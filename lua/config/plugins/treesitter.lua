return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local treesitter_configs = require("nvim-treesitter.configs")

      treesitter_configs.setup({
        ensure_installed = "all",
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
