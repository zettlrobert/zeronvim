-- vtsls (TypeScript / JavaScript LSP wrapping tsserver)
-- https://github.com/yioneko/vtsls
-- Settings: https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
-- Install: Mason -> vtsls (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config

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
