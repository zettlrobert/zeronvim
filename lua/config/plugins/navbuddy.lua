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
          auto_attach = true,
        },
      })

      -- <leader>s namespace (symbols) — room for future <leader>sd/sw
      vim.keymap.set("n", "<leader>ss", navbuddy.open, { desc = "Navbuddy: open" })
    end,
  },
}
