-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim"
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")
      local language_servers = require("config.plugins.lsp.servers").language_servers
      local formatters = require("config.plugins.lsp.servers").formatters
      local debug_adapters = require("config.plugins.lsp.servers").debug_adapters

      -- LSP
      local mason_servers = {}
      for key, _ in pairs(language_servers) do
        table.insert(mason_servers, key)
      end

      mason.setup({})
      mason_lspconfig.setup({
        ensure_installed = mason_servers,

        automatic_installation = false,
      })


      -- Formatters & Debug Adapters
      local mason_tools = {}
      for key, _ in pairs(formatters) do
        table.insert(mason_tools, key)
      end

      for key, _ in pairs(debug_adapters) do
        table.insert(mason_tools, key)
      end

      mason_tool_installer.setup({
        ensure_installed = mason_tools
      })
    end,
  },
}
