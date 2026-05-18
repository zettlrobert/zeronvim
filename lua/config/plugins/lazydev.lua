-- https://github.com/folke/lazydev.nvim
-- Configures lua-language-server for editing Neovim configs:
-- pulls in nvim runtime types + vim.uv (luv) library so that `vim`,
-- `vim.uv`, `vim.api`, etc. resolve correctly instead of reporting
-- "Undefined global `vim`".

return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
