local icons = require("icons")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local mason = require("mason")
    local nvim_lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Handle Binary Installation of Servers
    mason.setup({
      ui = {
        icons = {
          package_installed = icons.mason.package_installed,
          package_pending = icons.mason.package_pending,
          package_uninstalled = icons.mason.package_uninstalled,
        }
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
      }
    })

    -- Create object that represent the capabilities of the Neovim completion plugin
    local cmp_capabilities = cmp_nvim_lsp.default_capabilities()

    -- Creates a new object that represents the capabilities of the LSP client
    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Enable lsp completion with snippets
    lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Set the properties that the LSP client will resolve when completing items
    lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }

    -- Merges the capabilities of the Neovim completion plugin and the LSP client into one object
    local extended_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, cmp_capabilities)

    -- Default LSP Handler
    local default_handler = function(server)
      nvim_lspconfig[server].setup({
        capabilities = extended_capabilities
      })
    end

    -- Handle the LSP setup
    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "cssmodules_ls",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "htmx",
        --"biome",
        "tsserver",
        "lua_ls",
        "marksman",
        "mdx_analyzer",
        --"nil_ls",
        "prismals",
        "pyright",
        "rust_analyzer",
        "sqls",
        "svelte",
        "taplo",
        "tailwindcss",
        "terraformls",
        "tflint",
        "volar",
        "yamlls"
      },
      automatic_installation = true,
      handlers = {
        default_handler,
        -- Add overwrites for language specific handlers
      }
    })

    -- Ensure Hover Doc has rounded border
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    -- Handle the auto installation of tools via Mason
    mason_tool_installer.setup({
      ensure_installed = {
        "stylua",
        "prettierd",
        "eslint_d"
      }
    })

    -- local function, for better assignment in lsp keymaps
    local function list_workspace_folders()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end

    -- Autocommand to setup keybinds on lsp attach
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', '<space>sig', vim.lsp.buf.signature_help) -- todo: define better keymap
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
        vim.keymap.set('n', '<space>wl', list_workspace_folders)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename)
      end
    })
  end
}
