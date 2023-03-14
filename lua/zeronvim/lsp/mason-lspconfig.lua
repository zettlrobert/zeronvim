local utils = require "zeronvim.utils"
local handlers = require "zeronvim.lsp.lsp-handlers"
local mason_lspconfig = utils.protected_plugin_call("mason-lspconfig")
local lspconfig = utils.protected_plugin_call("lspconfig")

if mason_lspconfig and lspconfig and handlers then
  handlers.setup()

  mason_lspconfig.setup({
    -- Available Lsp Servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    ensure_installed = {
      "awk_ls",
      --"angularls",
      --"ansiblels",
      --"arduino_language_server",
      --"astro",
      "bashls",
      "clangd",
      --"cmake",
      "cssls",
      --"denols",
      "dockerls",
      "eslint",
      --"elixirls",
      "gopls",
      -- "graphql",
      "html",
      "jsonls",
      --"ltex",
      -- "sumneko_lua",
      "lua_ls",
      -- "rnix",
      -- "prismals",
      "pyright",
      -- "r_language_server",
      "rust_analyzer",
      "sqlls",
      --"svelte",
      -- "tailwindcss",
      "terraformls",
      -- "tflint",
      "tsserver",
      --"vuels",
      "yamlls",
    },
    automatic_installation = true
  })

  -- list of all mason installed langauge servers
  local installed_servers = mason_lspconfig.get_installed_servers()

  -- Loop over all availalbe langauge servers, and use mason default setup
  local function server_setup()
    -- Default options every language server receives
    local server_configuration_options = {
      on_attach = handlers.on_attach
    }

    -- Function to extend the default configuration with a server specific one
    local function deep_extend_server_config(provider_config)
      return vim.tbl_deep_extend("force", provider_config, server_configuration_options)
    end

    -- Itterate over every installed server and call the setup function with the configuration, overwrite if desired
    for _, server in pairs(installed_servers) do
      lspconfig[server].setup(server_configuration_options)

      -- Override defaults for servers
      if server == "sumneko_lua" then
        local sumneko_lua_config = require "zeronvim.lsp.providers.sumneko_lua"
        local updated_server_config = deep_extend_server_config(sumneko_lua_config)
        lspconfig.sumneko_lua.setup(updated_server_config)
      end

      if server == "tsserver" then
        local tsserver_config = require "zeronvim.lsp.providers.tsserver"
        local updated_server_config = deep_extend_server_config(tsserver_config)
        lspconfig.tsserver.setup(updated_server_config)
      end

      if server == "deno" then
        local deno_config = require "zeronvim.lsp.providers.denols"
        local updated_server_config = deep_extend_server_config(deno_config)
        lspconfig.deno.setup(updated_server_config)
      end

      if server == "ltex" then
        local ltex_config = require "zeronvim.lsp.providers.ltex-ls"
        local updated_server_config = deep_extend_server_config(ltex_config)
        lspconfig.ltex.setup(updated_server_config)
      end

      if server == "yamlls" then
        local yaml_config = require "zeronvim.lsp.providers.yamlls"
        local updated_server_config = deep_extend_server_config(yaml_config)
        lspconfig.yamlls.setup(updated_server_config)
      end
    end
  end

  -- advanced feature to setup servers automatically
  mason_lspconfig.setup_handlers {
    server_setup,
  }
end
