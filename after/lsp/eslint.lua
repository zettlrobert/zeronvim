-- vscode-eslint-language-server
-- https://github.com/hrsh7th/vscode-langservers-extracted
-- Settings: https://github.com/microsoft/vscode-eslint#settings-options
-- Install: Mason -> eslint-lsp (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config

-- cmd (prefers the project's node_modules/.bin), filetypes (incl. vue,
-- svelte, astro) and root_dir (nearest ESLint config) come from
-- nvim-lspconfig, which also provides the handlers ESLint needs. Override:
-- settings only.

return {
  settings = {
    useFlatConfig = true,
    workingDirectory = {
      mode = "auto",
    },
  },
}
