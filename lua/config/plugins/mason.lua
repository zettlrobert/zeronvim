-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--
-- LSP servers to install are derived from filenames in ~/.config/nvim/lsp/
-- (filtered to what mason-lspconfig knows about — e.g. nil_ls and tsgo have
-- lsp/ configs but no Mason package, so they're skipped here).
-- Formatters + debug adapters come from lua/config/lsp/tools.lua.

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
      local lsp = require("config.lsp")
      local tools = require("config.lsp.tools")
      local icons = require("config.assets.icons")

      --- Intersect the lsp/ filenames with the servers mason-lspconfig knows
      --- about, so we don't ask Mason to install things it can't (nil_ls, tsgo).
      local function mason_installable_lsps()
        local all = lsp.servers_from_dir()
        local ok, mappings_mod = pcall(require, "mason-lspconfig.mappings")
        if not ok then
          return all
        end
        local lspconfig_to_package = mappings_mod.get_mason_map
            and mappings_mod.get_mason_map().lspconfig_to_package
          or mappings_mod.lspconfig_to_package
        if not lspconfig_to_package then
          return all
        end
        local known = {}
        for _, name in ipairs(all) do
          if lspconfig_to_package[name] then
            table.insert(known, name)
          end
        end
        return known
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
        ensure_installed = mason_installable_lsps(),
        -- We call vim.lsp.enable() ourselves in config.lsp from the scanned
        -- lsp/ filenames — disable mason-lspconfig's auto-enable to avoid
        -- double-enabling.
        automatic_enable = false,
      })

      -- Formatters & Debug Adapters
      local mason_tools = {}
      for key, _ in pairs(tools.formatters) do
        table.insert(mason_tools, key)
      end
      for key, _ in pairs(tools.debug_adapters) do
        table.insert(mason_tools, key)
      end

      mason_tool_installer.setup({
        ensure_installed = mason_tools,
      })
    end,
  },
}
