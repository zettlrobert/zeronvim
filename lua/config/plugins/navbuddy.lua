-- https://github.com/SmiteshP/nvim-navbuddy
return {
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "MunifTanjim/nui.nvim",
     "numToStr/Comment.nvim",
    },
    config = function()
      local navbuddy = require("nvim-navbuddy")

      navbuddy.setup({
        lsp = {
          auto_attach = true
        }
      })

      vim.keymap.set("n", "<leader>s", navbuddy.open, { desc = "Navbuddy toggle navbuddy" })
    end
  }
}
