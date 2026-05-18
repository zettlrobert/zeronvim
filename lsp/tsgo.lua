-- tsgo (TypeScript Go port — experimental native TypeScript compiler)
-- https://github.com/microsoft/typescript-go
-- Install: npm i -g @typescript/native-preview  (provides `tsgo` binary)
-- :h lsp-config

local function is_tsgo_installed()
  return vim.fn.executable("tsgo") == 1
end

if is_tsgo_installed() == false then
  vim.notify("tsgo is not installed. Please install it to enable the tsgo LSP server.")
  return
end

return {
  cmd = { "tsgo", "--stdio" },
  root_markers = { "tsconfig.base.json", "nx.json", "package.json", ".git" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
