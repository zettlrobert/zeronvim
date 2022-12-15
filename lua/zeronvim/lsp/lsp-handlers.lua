local utils = require "zeronvim.utils"
local cmp_nvim_lsp = utils.protected_plugin_call('cmp_nvim_lsp')
local nvim_navic = utils.protected_plugin_call('nvim-navic')

local M = {}

-- local function, for better assignment in lsp keymaps
local function list_workspace_folders()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

-- local function to set lsp specific keymaps
local function lsp_keymaps(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>sig', vim.lsp.buf.signature_help, bufopts) -- todo: define better keymap
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', list_workspace_folders, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Setup function for base lsp configuration
M.setup = function()
  -- Store Signso
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  -- Define Signs
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- Configuration object for diagnostics
  local diagnostic_config = {
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(diagnostic_config)
end

--Callback invoked by Nvim's built-in client when attaching a buffer to a language server.
M.on_attach = function(client, bufnr)
  -- Add LSP Keymaps
  lsp_keymaps(bufnr)

  -- If nvim_navic could load and  server supports document symbol provicers, attach nvim_navic
  if nvim_navic and client.server_capabilities.documentSymbolProvider then
    nvim_navic.attach(client, bufnr)
  end
end

-- Gets a new ClientCapabilities object describing the LSP client capabilities.
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Update capabilities for completion
if cmp_nvim_lsp then
  M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

function M.get_lsp_options()
  return {
    on_attach = M.on_attach,
  }
end

return M
