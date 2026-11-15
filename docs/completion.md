# Completion

## TLDR

`blink.cmp` is the completion engine. It merges candidates from LSP, snippets, buffer, path, omnifunc and the AI
providers into one menu. Configured in `lua/config/plugins/completion.lua`.

## Sources

`sources.default` is a function: it returns the base list and adds the AI sources only while their provider is on. A
static list would load the lazy AI plugins on the first completion, because blink requires every listed provider before
checking `enabled`.

| Source | Provider | Gives you | Active |
|---|---|---|---|
| `lsp` | LSP servers ([lsp.md](lsp.md)) | Symbols, signatures, docs | Always |
| `path` | built-in | File paths | Always |
| `snippets` | `rafamadriz/friendly-snippets` | Language snippets | Always |
| `buffer` | built-in | Words from open buffers | Always |
| `omni` | built-in (`blink.cmp.sources.complete_func`) | The filetype's `omnifunc` | Always |
| `markdown` | `render-markdown.nvim` | Markdown completions | Markdown only (`per_filetype`) |
| `copilot` | `blink-cmp-copilot` | Copilot (cloud), `score_offset = 100` | While Copilot is on |
| `minuet` | `minuet.blink` | Local Ollama FIM, `score_offset = 50`, 3000 ms timeout | While Minuet is on ([ai.md](ai.md)) |

## Disabled in

See the `enabled` function in `completion.lua`:

- `oil` filetype
- `prompt` buftype
- Buffers with `vim.b.completion == false`

## Display

- Docs window opens after 250 ms on the selected item.
- Ghost text previews the selected item.
- Signature help is on, with a `rounded` border (blink ignores `winborder`).
- Kind icons come from mini.icons.

## Lua completion

`lazydev.nvim` (`lua/config/plugins/lazydev.lua`, `ft = "lua"`) feeds Neovim runtime types and `vim.uv` to `lua_ls`.
`vim.api.*` and `vim.uv.*` complete, and "Undefined global `vim`" goes away.

## Keymap preset

`keymap = { preset = "default" }`: built-in completion style (`<C-y>` accept, `<C-n>`/`<C-p>` select, `<C-Space>` open).
Alternatives: `"super-tab"` (VS Code style) and `"enter"` (accept with Enter).

## Adding a new source

1. Add the source plugin to blink.cmp's `dependencies` in `completion.lua`.
2. Register it in `sources.providers` with a `name` and `module`.
3. Add its key to the list returned by the `sources.default` function (or to `per_filetype` for one filetype).

## Related

- [lsp.md](lsp.md) - LSP is the primary completion source.
- [ai.md](ai.md) - Copilot and Minuet toggles.
