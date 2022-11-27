local utils = require "zeronvim.utils"
local mason_lspconfig = utils.protected_plugin_call("mason-lspconfig")

if mason_lspconfig then
  mason_lspconfig.setup({
    ensujre_installed = {
      "sumneko_lua"
    },

    automatic_installation = true
  })
end
