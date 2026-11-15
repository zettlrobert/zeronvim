# Linting

## TLDR

Two layers. **LSP servers** lint where the tool ships as a server (eslint, vale-ls, tflint). **nvim-lint** runs
standalone linters (markdownlint-cli2, shellcheck, hadolint, yamllint, ruff, selene, golangci-lint, actionlint). Both
report through `vim.diagnostic`. Filetypes linted by an LSP are left out of nvim-lint to avoid double diagnostics.

## Files

| Path | Role |
|---|---|
| `after/lsp/*.lua` | LSP-based linters (see [lsp.md](lsp.md)) |
| `lua/config/plugins/nvim-lint.lua` | nvim-lint spec, filetype-to-linter map, autocmds, profile binaries |
| `lua/config/lsp/tools.lua` | Mason install list for linters (`M.linters`) |
| `lua/config/utils/toggle_linter.lua` | Per-linter enable/disable for the session |
| `lua/config/utils/lint_versions.lua` | `:LintVersions` and the startup check: git hooks' linters vs Mason |
| `.markdownlint.jsonc` | markdownlint rules for this repo only |
| `selene.toml` + `vim.toml` | selene std config for the `vim` global |

## LSP-based linters

| Tool | LSP file | What it lints |
|---|---|---|
| eslint | `after/lsp/eslint.lua` | JS/TS/JSX/TSX, plus Vue, Svelte, Astro (lspconfig filetypes) |
| vale-ls | `after/lsp/vale_ls.lua` | Prose, on demand only: `filetypes = {}`, attach with `<leader>tl` (see [vale.md](vale.md)) |
| tsc | `after/lsp/tsc.lua` | TypeScript type errors (TypeScript 7); vtsls instead in Vue workspaces |
| tflint | `after/lsp/tflint.lua` | Terraform |

## nvim-lint linters

They run on `BufReadPost` and `BufWritePost`, never per keystroke. actionlint uses a path trigger
(`*/.github/workflows/*.yml`, `*.yaml`) so generic YAML is not flagged.

| Linter | Filetypes | Notes |
|---|---|---|
| markdownlint-cli2 | markdown | Shared rules from the git hooks; see below |
| shellcheck | sh, bash | |
| hadolint | dockerfile | |
| yamllint | yaml | |
| ruff | python | |
| selene | lua | Config: `selene.toml` + `vim.toml` |
| golangci-lint | go | nvim-lint name is `golangcilint` (no dash); the Mason package is `golangci-lint` |
| actionlint | GitHub workflow YAML | Path-based |

## Runtime toggle

Turn any nvim-lint linter off or on for the session:

```lua
require("config.utils.toggle_linter").toggle("markdownlint-cli2")
```

| Key | Action |
|---|---|
| `<leader>tm` | Toggle markdownlint-cli2 |

Disabling clears the linter's current diagnostics. State is in memory and resets on restart. Bind more toggles the same
way if a linter gets noisy.

## Same linters as the git hooks

shellcheck, yamllint, hadolint, actionlint and markdownlint-cli2 also run in the git hooks
([githooks](https://github.com/zettlrobert/githooks)). When the hooks package is in the nix profile, nvim-lint runs the
profile's copy (`~/.nix-profile/bin/`), so the editor reports what a commit will. Mason's copy is the fallback on
machines without the profile.

| Linter | Rules |
|---|---|
| shellcheck, yamllint, hadolint | User configs linked to the hooks' rules (configurations repo, `lint` stow package) |
| markdownlint-cli2 | `--config ~/.nix-profile/share/githooks/markdownlint.yaml`; a repo `.markdownlint-cli2.yaml` merges on top |
| actionlint | No config |

A repo's own config still wins for each tool.

Only these five are swapped. A global Mason `PATH = "append"` would also swap LSPs and formatters (rust-analyzer, ruff,
tsc) for older or broken copies on `PATH`.

**Version drift.** `:LintVersions` shows the profile's and Mason's version of each linter and which copy the editor
uses. A few seconds after startup the same check runs in the background. When Mason is newer than the profile, a `WARN`
notification (title "Linters", also in `<leader>nh`) says the hooks' toolchain is behind. Each version pair warns once
(state in `~/.local/state/nvim/lint-versions.json`). Fix it in nix-profiles:
`nix flake update` in core, then `nix profile upgrade`. Without the profile there is nothing to compare and the check stays silent.

## Where diagnostics surface

Configured in `lua/config/lsp/init.lua`:

| Surface | Setting or key |
|---|---|
| Virtual text, current line only | `virtual_text = { current_line = true }` |
| Virtual lines, current line only | `virtual_lines = { current_line = true }` |
| Sign column | `signs = true` |
| Underline | `underline = true` |
| Float (rounded border) | `<leader>d` |
| Jump next / previous | `]d` / `[d` (Neovim defaults) |
| Loclist | `<leader>lq` |
| Quickfix | `<leader>qd` (all), `<leader>qe` (errors) |

## Add a linter that ships as an LSP

Add a file to `after/lsp/`, like any server. See [lsp.md](lsp.md).

## Add a linter that does not ship as an LSP

1. Add the Mason package to `M.linters` in `lua/config/lsp/tools.lua`.
2. Map filetypes in `lint.linters_by_ft` in `nvim-lint.lua`.
3. Optional: add a `<leader>t<key>` keymap calling `toggle_linter.toggle("<name>")`.
4. Restart nvim. Check `:Mason` for the install.

## Config files

**`.markdownlint.jsonc`** (repo root): `MD013` at 180 columns (not for tables, code or headings), `MD033` and `MD041`
off, `MD024` siblings only. It applies only inside this repo and replaces the shared rules instead of merging. For a
per-repo tweak elsewhere, use `.markdownlint-cli2.yaml`, which merges.

**`selene.toml` + `vim.toml`** (repo root): `std = "vim"` extends `lua51` and accepts any `vim.*` access, so selene does
not flag every `vim.api.*` call. Only this repo needs it.

## Related

- [lsp.md](lsp.md) - the source of most diagnostics.
- [formatting.md](formatting.md) - separate concern; eslint both lints and fixes.
- [nvim-lists.md](nvim-lists.md) - send diagnostics to quickfix or loclist.
