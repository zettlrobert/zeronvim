-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local server_list = require("config.plugins.lsp.servers").server_list
      local mason_servers = {}

      for key, _ in pairs(server_list) do
        table.insert(mason_servers, key)
      end

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = mason_servers,

        automatic_installation = false,
      })
    end,
  },
}
