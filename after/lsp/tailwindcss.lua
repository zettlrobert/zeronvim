-- tailwindcss-language-server
-- https://github.com/tailwindlabs/tailwindcss-intellisense
-- Install: Mason -> tailwindcss-language-server
-- Settings: https://github.com/tailwindlabs/tailwindcss-intellisense/blob/HEAD/packages/tailwindcss-language-server/README.md
-- :h lsp-config

-- cmd (prefers the project's node_modules/.bin) and root_dir come from
-- nvim-lspconfig; its root_dir also finds Tailwind v4 projects, which have no
-- tailwind.config file. Override: a narrower filetype list than upstream's.

return {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "svelte",
    "astro",
    "vue",
    "mdx",
  },
}
