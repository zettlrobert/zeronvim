-- tsgo (TypeScript Go port — experimental native TypeScript compiler)
-- https://github.com/microsoft/typescript-go
-- Install: external — `npm i -g @typescript/native-preview` (not in Mason registry)
-- :h lsp-config

return {
  cmd = { "tsgo", "--stdio" },
  root_markers = { "tsconfig.base.json", "nx.json", "package.json", ".git" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
