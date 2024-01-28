-- https://github.com/SmiteshP/nvim-navic
-- https://github.com/LunarVim/breadcrumbs.nvim
return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig",
    "LunarVim/breadcrumbs.nvim"
  },
  config = function()
    local navic = require("nvim-navic")
    local breadcrumbs = require("breadcrumbs")

    navic.setup({
      lsp = {
        auto_attach = true,
      },
      highlight = true
    })

    breadcrumbs.setup({})
  end
}
