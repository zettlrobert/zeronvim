-- astro-language-server
-- https://github.com/withastro/language-tools
-- Install: Mason -> astro-language-server (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config
--
-- cmd and filetypes come from nvim-lspconfig (its cmd prefers the project's
-- node_modules/.bin/astro-ls). Override: root on the Astro config first.

return {
  root_markers = { "astro.config.mjs", "astro.config.ts", "package.json", ".git" },
}
