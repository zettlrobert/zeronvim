--https://github.com/SmiteshP/nvim-navic
return {
  {
    "SmiteshP/nvim-navic",
    config = function()
      local navic = require("nvim-navic")

      navic.setup({
        lsp = {
          auto_attach = true,
        },
        highlight = true
      })
    end
  }
}
