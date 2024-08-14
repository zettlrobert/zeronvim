-- https://github.com/nvim-treesitter/nvim-treesitter - Nvim Treesitter configurations and abstraction layer
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "typescript",
          "lua",
          "c",
          "norg",
          "go",
          "rust",
          "bash",
          "yaml",
          "vue",
          "scss",
          "markdown",
          "markdown_inline",
          "json",
          "nix",
        },
        sync_install = true,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
