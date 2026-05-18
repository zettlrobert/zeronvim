# Formatting

## TLDR

`conform.nvim` runs formatters on `BufWritePre`. If no formatter is configured for a filetype, it falls back to LSP formatting (`vim.lsp.buf.format`). Configured in `lua/config/plugins/conform.lua`.

## Files

| Path | Role |
|---|---|
| `lua/config/plugins/conform.lua` | Plugin spec: formatter-to-filetype map, per-formatter args, format-on-save hook. |
| `lua/config/lsp/tools.lua` | Mason install list for formatter binaries (`prettierd`, `stylua`). |
| `lua/config/plugins/mason.lua` | Reads `tools.lua` and installs formatters via `mason-tool-installer`. |

## What formats what

| Filetype | Formatter |
|---|---|
| `lua` | stylua |
| `javascript`, `javascriptreact`, `typescript`, `typescriptreact` | prettierd |
| `json`, `jsonc`, `yaml`, `html`, `css`, `scss`, `markdown`, `mdx`, `astro`, `svelte`, `vue` | prettierd |
| anything else with an LSP that supports `textDocument/formatting` | LSP (via `lsp_format = "fallback"`) |

So `eslint --fix` on save still works for JS/TS because vscode-eslint-language-server provides formatting — conform handles prettierd, LSP handles eslint.

## Format-on-save skip

`*.presentation.md` files are skipped — see `is_presentation_markdown()` in `lua/config/utils/`. Useful for slide decks where prettier breaks formatting.

## Override formatter flags

Set `prepend_args` (or `args` for full override) in `conform.lua`:

```lua
formatters = {
  prettierd = {
    prepend_args = { "--printWidth=80", "--single-quote", "--semi=true", ... },
  },
}
```

Note: these are passed on every invocation, ignoring any project `.prettierrc`. Drop them if you want per-project config to win.

## Add a new formatter

1. Add the binary key to `lua/config/lsp/tools.lua` under `M.formatters` so Mason installs it.
2. Map filetypes in `conform.lua` under `formatters_by_ft`.
3. (Optional) Add per-formatter `prepend_args` under `formatters`.
4. Restart nvim. `:Mason` to verify install.

## Manual format

`<leader>fmt` runs `vim.lsp.buf.format({ async = true })` — bypasses conform, uses LSP only.

To run conform manually: `:lua require("conform").format()` or set up a keymap.

## Related

- [lsp.md](lsp.md) — LSP formatting is the fallback path.
- [linting.md](linting.md) — separate concern; some tools (e.g. eslint) do both.
