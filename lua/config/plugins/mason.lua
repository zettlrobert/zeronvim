-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")
      local language_servers = require("config.plugins.lsp.servers").language_servers
      local formatters = require("config.plugins.lsp.servers").formatters
      local debug_adapters = require("config.plugins.lsp.servers").debug_adapters
      local icons = require("config.assets.icons")

      -- LSP
      local mason_servers = {}
      for key, _ in pairs(language_servers) do
        table.insert(mason_servers, key)
      end

      mason.setup({
        ui = {
          icons = {
            package_installed = icons.Mason.package_installed,
            package_pending = icons.Mason.package_pending,
            package_uninstalled = icons.Mason.package_uninstalled,
          },
        },
        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      })

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
        ensure_installed = mason_tools,
      })
    end,
  },
}
