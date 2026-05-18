-- tailwindcss-language-server
-- https://github.com/tailwindlabs/tailwindcss-intellisense
-- Install: Mason -> tailwindcss-language-server
-- Settings: https://github.com/tailwindlabs/tailwindcss-intellisense/blob/HEAD/packages/tailwindcss-language-server/README.md
-- :h lsp-config

return {
  cmd = { "tailwindcss-language-server", "--stdio" },
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
  -- Only attaches when one of these config files is present in the project,
  -- so safe to enable globally — non-tailwind projects will simply not attach
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
  },
}
