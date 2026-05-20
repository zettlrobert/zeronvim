local M = {}

--[[
Categorized picker over the LSP actions available at the cursor. Renders via
vim.ui.select so it inherits whatever ui.select handler is active (snacks,
dressing, telescope-ui-select, the built-in popup, ...).

Each catalog entry:
  - category: Navigate | Refactor | Fix | Info  (visual grouping)
  - title:    short label shown in the picker
  - desc:     one-line description (the "what does this do?" cheat sheet)
  - method:   LSP method tested via client:supports_method. nil = always shown.
  - run:      function() invoked on selection.

To add an action: append to the catalog. To change ordering: reorder entries.
To customize rendering for this picker specifically: handle kind = "lsp_actions"
in your ui.select handler.
]]
local catalog = {
  -- Navigate
  {
    category = "Navigate",
    title = "Definition",
    method = "textDocument/definition",
    desc = "Jump to where the symbol is defined",
    run = function() vim.lsp.buf.definition() end,
  },
  {
    category = "Navigate",
    title = "Declaration",
    method = "textDocument/declaration",
    desc = "Jump to the symbol's declaration",
    run = function() vim.lsp.buf.declaration() end,
  },
  {
    category = "Navigate",
    title = "Implementation",
    method = "textDocument/implementation",
    desc = "Jump to an interface implementation",
    run = function() vim.lsp.buf.implementation() end,
  },
  {
    category = "Navigate",
    title = "Type definition",
    method = "textDocument/typeDefinition",
    desc = "Jump to the symbol's type",
    run = function() vim.lsp.buf.type_definition() end,
  },
  {
    category = "Navigate",
    title = "References",
    method = "textDocument/references",
    desc = "List all references to the symbol",
    run = function() vim.lsp.buf.references() end,
  },

  -- Refactor
  {
    category = "Refactor",
    title = "Rename symbol",
    method = "textDocument/rename",
    desc = "Rename the symbol across the workspace",
    run = function() vim.lsp.buf.rename() end,
  },
  {
    category = "Refactor",
    title = "Format buffer",
    method = "textDocument/formatting",
    desc = "Format the entire buffer via LSP",
    run = function() vim.lsp.buf.format({ async = true }) end,
  },

  -- Fix
  {
    category = "Fix",
    title = "Code actions",
    method = "textDocument/codeAction",
    desc = "Quick fixes and refactors at cursor",
    run = function() vim.lsp.buf.code_action() end,
  },

  -- Info
  {
    category = "Info",
    title = "Hover",
    method = "textDocument/hover",
    desc = "Show documentation for the symbol",
    run = function() vim.lsp.buf.hover() end,
  },
  {
    category = "Info",
    title = "Signature help",
    method = "textDocument/signatureHelp",
    desc = "Show function signature with parameters",
    run = function() vim.lsp.buf.signature_help() end,
  },
  {
    category = "Info",
    title = "Document symbols",
    method = "textDocument/documentSymbol",
    desc = "List all symbols in the current file",
    run = function() vim.lsp.buf.document_symbol() end,
  },
  {
    category = "Info",
    title = "Workspace symbols",
    method = "workspace/symbol",
    desc = "Fuzzy-find symbols across the project",
    run = function() vim.lsp.buf.workspace_symbol() end,
  },
  {
    category = "Info",
    title = "Diagnostic float",
    method = nil, -- diagnostics come from vim.diagnostic, not LSP capability
    desc = "Show diagnostics at cursor in a floating window",
    run = function() vim.diagnostic.open_float() end,
  },
}

---Filter the catalog to actions supported by at least one client attached
---to the given buffer. Entries with method = nil are always included.
local function supported_actions(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local items = {}
  for _, item in ipairs(catalog) do
    local supported = item.method == nil
    if not supported then
      for _, client in ipairs(clients) do
        if client:supports_method(item.method, { bufnr = bufnr }) then
          supported = true
          break
        end
      end
    end
    if supported then
      table.insert(items, item)
    end
  end
  return items
end

local lsp_actions = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local items = supported_actions(bufnr)

  if #items == 0 then
    vim.notify("No LSP actions available for this buffer", vim.log.levels.WARN, { title = "LSP actions" })
    return
  end

  vim.ui.select(items, {
    prompt = "LSP actions",
    kind = "lsp_actions",
    format_item = function(item)
      return ("%-10s  %-20s  %s"):format("[" .. item.category .. "]", item.title, item.desc)
    end,
  }, function(choice)
    if choice then
      choice.run()
    end
  end)
end

M.lsp_actions = lsp_actions

return M
