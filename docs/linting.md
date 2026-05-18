# Linting

## TLDR

**LSP-first**: most modern linters ship as LSP servers and live in `lsp/<name>.lua`. Diagnostics flow into Neovim's native `vim.diagnostic` pipeline. No separate linter manager configured — and none needed for the current set of tools.

## Active linters

| Tool | How | What it lints |
|---|---|---|
| eslint | LSP (`lsp/eslint.lua`) | JS/TS/JSX/TSX (also Svelte, Astro) |
| vale-ls | LSP (`lsp/vale_ls.lua`) | Prose in `markdown`, `text`, `tex`, `rst`, `mdx` |
| vtsls | LSP (`lsp/vtsls.lua`) | TypeScript type errors |
| Treesitter parsers | Built-in | Syntax errors via highlight regions |

## Where diagnostics surface

Configured in `lua/config/lsp/init.lua`:

| Surface | Setting |
|---|---|
| Inline virtual text on current line | `virtual_text = { current_line = true }` |
| Virtual lines (below code) on current line | `virtual_lines = { current_line = true }` |
| Signcolumn signs | `signs = true` |
| Underline | `underline = true` |
| Floating window | `<space>d` (`vim.diagnostic.open_float`) |
| Jump next/prev | `[d` / `]d` |
| Loclist | `<space>lq` |

## Add a linter that ships as an LSP

Same as adding any LSP server — see [lsp.md](lsp.md). Just drop a file in `lsp/`.

## Add a linter that does NOT ship as an LSP

Examples: `markdownlint`, `hadolint`, `codespell`, `shellcheck` standalone.

You'd install [`mfussenegger/nvim-lint`](https://github.com/mfussenegger/nvim-lint) (the "modern none-ls for linters" companion to conform.nvim) and wire it up:

```lua
require("lint").linters_by_ft = { markdown = { "markdownlint" } }
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function() require("lint").try_lint() end,
})
```

Plus install the binary via `lua/config/lsp/tools.lua` (add under a new `M.linters` table and update `mason.lua` to consume it).

**Not currently installed** — add only when you need a linter without an LSP.

## Related

- [lsp.md](lsp.md) — the primary mechanism for diagnostics.
- [formatting.md](formatting.md) — different concern; some tools (eslint) do both linting and `--fix` formatting.
