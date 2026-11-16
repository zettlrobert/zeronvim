# Formatting

## TLDR

`conform.nvim` formats on save (`BufWritePre`, 1000 ms timeout). A filetype with a configured formatter uses only that
formatter. A filetype without one falls back to LSP formatting. `<leader>lf` formats manually with the same rules.
Configured in `lua/config/plugins/conform.lua`.

## Files

| Path | Role |
|---|---|
| `lua/config/plugins/conform.lua` | Filetype map, formatter args, format-on-save hook |
| `lua/config/keymaps.lua` | `<leader>lf` manual format |
| `lua/config/lsp/tools.lua` | Mason install list for formatters (`prettierd`, `stylua`) |
| `lua/config/plugins/mason.lua` | Installs `tools.lua` entries through mason-tool-installer |
| `.stylua.toml` | Lua style for this repo |

## What formats what

| Filetype | Formatter |
|---|---|
| `lua` | stylua |
| `javascript`, `javascriptreact`, `typescript`, `typescriptreact` | prettierd |
| `json`, `jsonc`, `html`, `css`, `scss`, `mdx`, `astro`, `svelte`, `vue` | prettierd |
| `markdown` | `prettierd_project` inside a prettier project, otherwise `markdownlint-cli2` |
| `yaml` | `prettierd_project`: only inside a prettier project; no LSP fallback |
| anything else with an LSP that supports `textDocument/formatting` | LSP (`lsp_format = "fallback"`) |

`"fallback"` means LSP formatting runs only when conform has no formatter for the filetype. JS/TS therefore get
prettierd only: ESLint fixes do not run on save. Apply them through code actions (`<leader>lc`).

## Format-on-save skip

`*.presentation.md` files are never formatted on save (`is_presentation_markdown()` in `lua/config/utils/`). Prettier
breaks slide decks.

## Formatter flags

`prettierd` gets fixed `prepend_args` in `conform.lua`:

```lua
prettierd = {
  prepend_args = { "--printWidth=80", "--single-quote", "--trailing-comma=all", "--semi=true", ... },
},
```

These flags apply on every run and override any project `.prettierrc`. Drop them to let per-project config win. Use
`args` instead of `prepend_args` to replace the arguments entirely.

Markdown and YAML use `prettierd_project` instead: it inherits `prettierd` but has `require_cwd = true`. It runs only
where it finds a `.prettierrc*`, a `prettier.config.*` or a `"prettier"` key in `package.json`, and uses that project's
settings. LSP fallback is off for both, because yamlls would otherwise reformat with its own prettier defaults.

Outside a prettier project, markdown gets `markdownlint-cli2 --fix`: lint fixes only, no re-wrapping or quote
changes. Without a project markdownlint config it uses `.markdownlint.jsonc` from this repo, which turns off MD060 so
compact `|---|` table delimiters stay as written. YAML is left alone outside prettier projects.

## Add a new formatter

1. Add the Mason package to `M.formatters` in `lua/config/lsp/tools.lua`.
2. Map filetypes under `formatters_by_ft` in `conform.lua`.
3. Optional: add `prepend_args` under `formatters`.
4. Restart nvim. Check `:Mason` for the install and `:ConformInfo` for the mapping.

## Lua style in this repo

`.stylua.toml` sets 2-space indents, a 120-column limit and `AutoPreferDouble` quotes. conform's `stylua` `prepend_args`
pass the same indent flags, so Lua files outside this repo get them too. `lua/config/options.lua` opts out
(`-- stylua: ignore`) to keep its aligned comments.

## Related

- [lsp.md](lsp.md) - LSP formatting is the fallback path.
- [linting.md](linting.md) - separate concern; some tools (eslint) both lint and fix.
