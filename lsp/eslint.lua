-- vscode-eslint-language-server
-- https://github.com/hrsh7th/vscode-langservers-extracted
-- Settings: https://github.com/microsoft/vscode-eslint#settings-options
-- :h lsp-config

local function is_vscode_eslint_installed()
  return vim.fn.executable("vscode-eslint-language-server") == 1
end

if is_vscode_eslint_installed() == false then
  vim.notify("vscode-eslint is not installed. Please install it to enable the eslint LSP server.")
  return
end

return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  -- nx monorepo: nx.json + tsconfig.base.json mark workspace root;
  -- eslint.config.* / .eslintrc.json handle per-project roots
  root_markers = {
    "eslint.config.mjs",
    "eslint.config.js",
    "eslint.config.ts",
    "eslint.config.cjs",
    ".eslintrc.json",
    "nx.json",
    "tsconfig.base.json",
    ".git",
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "svelte",
    "astro",
  },
  settings = {
    useFlatConfig = true,
    workingDirectory = {
      mode = "auto",
    },
  },
}
