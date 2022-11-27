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

  local sumneko_lua_config = require "zeronvim.lsp.providers.sumneko_lua"

  -- Loop over all availalbe langauge servers, and use mason default setup
  local function server_setup()
    for _, server in pairs(installed_servers) do
      lspconfig[server].setup{
        on_attach = handlers.on_attach
      }

      -- Override defaults for server
      if server == "sumneko_lua" then
        lspconfig.sumneko_lua.setup {
          on_attach = handlers.on_attach,
          settings = sumneko_lua_config
        }
      end

    end
  end

  -- advanced feature to setup servers automatically
  mason_lspconfig.setup_handlers {
    server_setup,
  }
end
