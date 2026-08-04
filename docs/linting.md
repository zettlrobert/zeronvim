# Linting

## TLDR

Two-layer setup: **LSP servers** for tools that ship as language servers (eslint, vale-ls, tflint), **nvim-lint** for standalone linters that don't (markdownlint, shellcheck, hadolint, yamllint, ruff, selene, golangci-lint, actionlint). Diagnostics from both flow into Neovim's native `vim.diagnostic` pipeline — no fragmentation.

## Files

| Path | Role |
|---|---|
| `lsp/*.lua` | LSP-based linters (see [lsp.md](lsp.md)) |
| `lua/config/plugins/nvim-lint.lua` | nvim-lint plugin spec + filetype → linter map + autocmds |
| `lua/config/lsp/tools.lua` | Mason install list for linter binaries (`M.linters`) |
| `lua/config/utils/toggle_linter.lua` | Runtime per-linter enable/disable |
| `.markdownlint.jsonc` | Repo-local markdownlint rules (line_length 180, no MD033/041 etc.) |
| `selene.toml` + `vim.toml` | Selene std config for vim globals |

## Active LSP-based linters

| Tool | LSP file | What it lints |
|---|---|---|
| eslint | `lsp/eslint.lua` | JS/TS/JSX/TSX (also Svelte, Astro) |
| vale-ls | `lsp/vale_ls.lua` | Prose in `markdown`, `text`, `tex`, `rst`, `mdx` |
| vtsls | `lsp/vtsls.lua` | TypeScript type errors |
| tflint | `lsp/tflint.lua` | Terraform |
| Treesitter parsers | Built-in | Syntax errors via highlight regions |

## Active nvim-lint linters

Fires on `BufWritePost` + `BufReadPost` for the buffer's filetype. actionlint uses a path-based trigger (`*/.github/workflows/*.yml`) to avoid false positives on generic YAML.

| Linter | Filetypes | Notes |
|---|---|---|
| markdownlint | markdown | Config: `.markdownlint.jsonc` at repo root |
| shellcheck | sh, bash | |
| hadolint | dockerfile | |
| yamllint | yaml | |
| ruff | python | Fast Python linter |
| selene | lua | Config: `selene.toml` + `vim.toml` for vim globals |
| golangci-lint | go | Slow — only fires on save/read, not per-keystroke |
| actionlint | GitHub workflow YAMLs | Path-based (only in `.github/workflows/`) |

## Runtime toggle

Any nvim-lint linter can be disabled for the session via `toggle_linter`:

```lua
require("config.utils.toggle_linter").toggle("markdownlint")
```

Wired keymap:

| Key | Action |
|---|---|
| `<leader>tm` | Toggle markdownlint |

State is in-memory; resets on nvim restart. See `lua/config/utils/toggle_linter.lua` — bind more toggles the same way if any specific linter proves noisy.

## Where diagnostics surface

Configured in `lua/config/lsp/init.lua`:

| Surface | Setting |
|---|---|
| Inline virtual text on current line | `virtual_text = { current_line = true }` |
| Virtual lines (below code) on current line | `virtual_lines = { current_line = true }` |
| Signcolumn signs | `signs = true` |
| Underline | `underline = true` |
| Floating window | `<leader>d` (`vim.diagnostic.open_float`) |
| Jump next/prev | `[d` / `]d` |
| Loclist | `<leader>lq` |

## Add a linter that ships as an LSP

Same as adding any LSP server — see [lsp.md](lsp.md). Just drop a file in `lsp/`.

## Add a linter that does NOT ship as an LSP

1. Add the binary key to `lua/config/lsp/tools.lua` under `M.linters` so Mason installs it.
2. Map filetypes in `nvim-lint.lua` under `lint.linters_by_ft`.
3. (Optional) Add a `<leader>t<key>` toggle keymap using `toggle_linter.toggle("<name>")`.
4. Restart nvim. `:Mason` to verify install.

## Config files

**`.markdownlint.jsonc`** at repo root — sets `line_length: 180` for prose, disables MD013 (line-length) checks in tables/code/headings, allows inline HTML (MD033), etc. Move to `~/.markdownlint.jsonc` to make global; markdownlint's config discovery walks up from the file.

**`selene.toml` + `vim.toml`** at repo root — declares `std = "vim"` and defines `vim` as an accept-any global so selene doesn't flag every `vim.api.*` call. Only needed for the nvim config repo itself; other lua projects use their own selene setup.

## Related

- [lsp.md](lsp.md) — the primary mechanism for many diagnostics.
- [formatting.md](formatting.md) — different concern; some tools (eslint) do both linting and `--fix` formatting.
- [ai.md](ai.md) — separate `<leader>a*` namespace for AI provider toggles.
