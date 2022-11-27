local utils = require "zeronvim.utils"
local lspconfig = utils.protected_plugin_call("lspconfig")

if lspconfig then
  vim.notify("Lsp File loaded, access to lsp config") -- TODO: remove this line
end

