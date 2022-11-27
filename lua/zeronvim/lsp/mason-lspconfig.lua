local utils = require "zeronvim.utils"
local handlers = require "zeronvim.lsp.lsp-handlers"
local mason_lspconfig = utils.protected_plugin_call("mason-lspconfig")
local lspconfig = utils.protected_plugin_call("lspconfig")

if mason_lspconfig and lspconfig and handlers then
  handlers.setup()

  mason_lspconfig.setup({
    ensure_installed = {
      "sumneko_lua",
      "bashls",
      "clangd",
      "cssls",
      "gopls",
      "graphql",
      "html",
      "jsonls",
      "pyright",
      "tsserver",
      "dockerls",
      "yamlls"
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
    end
  end

  -- advanced feature to setup servers automatically
  mason_lspconfig.setup_handlers {
    server_setup,
  }
end
