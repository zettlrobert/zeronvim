-- vtsls (TypeScript / JavaScript LSP wrapping tsserver)
-- https://github.com/yioneko/vtsls
-- Settings: https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
-- :h lsp-config

local function is_vtsls_installed()
  return vim.fn.executable("vtsls") == 1
end

if is_vtsls_installed() == false then
  vim.notify(
    "vtsls is not installed. Please install it to enable the vtsls LSP server. https://github.com/yioneko/vtsls",
    vim.log.levels.ERROR
  )
  return
end

return {
  cmd = { "vtsls", "--stdio" },
  -- nx monorepo: tsconfig.base.json + nx.json mark the workspace root;
  -- package.json keeps it working for non-nx projects
  root_markers = {
    "tsconfig.base.json",
    "nx.json",
    "package.json",
    ".git",
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
}
