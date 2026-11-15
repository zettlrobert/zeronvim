-- https://github.com/SmiteshP/nvim-navbuddy
return {
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",
    },
    -- Attached from lua/config/lsp/init.lua like nvim-navic. With auto_attach
    -- on, a late load walks existing clients through the deprecated
    -- vim.lsp.get_buffers_by_client_id. The <leader>ss keymap lives in
    -- config/keymaps.lua.
    lazy = true,
    opts = {
      lsp = {
        auto_attach = false,
      },
    },
  },
}
