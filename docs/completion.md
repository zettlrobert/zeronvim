# Completion

## TLDR

`blink.cmp` is the completion engine. It pulls candidates from multiple sources (LSP, snippets, AI, buffer, path) and renders them in a unified menu. Configured in `lua/config/plugins/completion.lua`.

## Sources (priority order)

| Source | Provider | What it gives you |
|---|---|---|
| `lsp` | LSP servers (see [lsp.md](lsp.md)) | Symbol completions, signatures, doc hover |
| `path` | built-in | File path completion |
| `snippets` | `rafamadriz/friendly-snippets` | Language snippets |
| `buffer` | built-in | Words from open buffers |
| `omni` | `cmp-omni` via blink.compat | Filetype-specific `omnifunc` |
| `markdown` | `render-markdown.nvim` | Markdown-aware completions |
| `codeium` | codeium.blink | AI completions (Codeium) |
| `copilot` | blink-cmp-copilot | AI completions (Copilot, score offset +100) |

## Disabled in

- `oil` filetype
- `prompt` buftype
- Buffers where `vim.b.completion == false`

See `enabled = function() ... end` in `completion.lua`.

## Lua completion

`lazydev.nvim` (`lua/config/plugins/lazydev.lua`) wires nvim runtime types into `lua_ls`, so `vim.api.*`, `vim.uv.*`, etc. all complete and the "Undefined global vim" diagnostic goes away. Loads on `ft = "lua"`.

## Keymap preset

Currently `keymap = { preset = "default" }` — built-in completion-style mappings. Alternatives in the blink.cmp docs: `"super-tab"` (vscode-style), `"enter"` (super-tab + enter to accept).

## Adding a new source

1. Add the source plugin as a `dependencies` entry on blink.cmp in `completion.lua`.
2. Register it in `sources.providers` (give it a `name` + `module`).
3. Add the source key to `sources.default` to enable it.

## Related

- [lsp.md](lsp.md) — LSP is the primary completion source.
