-- vscode-eslint-language-server
-- https://github.com/hrsh7th/vscode-langservers-extracted
-- Settings: https://github.com/microsoft/vscode-eslint#settings-options
-- Install: Mason -> eslint-lsp (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config

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
