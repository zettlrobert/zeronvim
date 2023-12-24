local utils = require "zeronvim.utils"
local null_ls = utils.protected_plugin_call("null-ls")
local prettier_options = require "zeronvim.lsp.null-ls.formatting.prettier"

if null_ls then
  local formatting = null_ls.builtins.formatting
  --[[ local default_opts = handlers.get_lsp_options ]]
  --[[ null_ls.setup(vim.tbl_deep_extend("force", default_opts, lvim.lsp.null_ls.setup)) ]]

  null_ls.setup({
    sources = {
      formatting['prettier'].with(prettier_options)
    }
  })
else
  vim.notify("ERROR: Could not load null-ls") -- TODO: Error handling
end
