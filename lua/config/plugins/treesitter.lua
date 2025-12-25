return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter_configs = require("nvim-treesitter.configs")

      treesitter_configs.setup({
        modules = {},
        ensure_installed = "all",
        sync_install = false,
        auto_install = true,
        ignore_install = {
          "ipkg",
          "swift",
          "latex",
          "mlir",
          "ocamllex",
          "scfg",
          "teal",
          "unison",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
