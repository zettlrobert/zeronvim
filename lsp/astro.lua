-- astro-language-server
-- https://github.com/withastro/language-tools
-- Install: Mason -> astro-language-server (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config

return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "astro.config.mjs", "astro.config.ts", "package.json", ".git" },
}
