return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = "all",
        sync_install = true,
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
