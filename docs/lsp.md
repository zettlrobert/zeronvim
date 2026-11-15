# LSP

## TLDR

Filenames in `after/lsp/` are the **single source of truth** for both `vim.lsp.enable()` and Mason's install list. Drop a file in `after/lsp/` to add a server, delete it to remove. No central list to maintain.

## Files

| Path | Role |
|---|---|
| `after/lsp/<name>.lua` | Per-server config. Merged on top of `nvim-lspconfig` defaults and wins on conflicts. Empty `return {}` is valid — uses defaults. |
| `lua/config/lsp/init.lua` | Scans `after/lsp/`, calls `vim.lsp.enable` per server in a pcall guard. Sets diagnostics config + global keymaps. |
| `lua/config/lsp/tools.lua` | Formatter + DAP install lists (consumed by `mason.lua`). LSP servers are NOT listed here — they come from the `after/lsp/` scan. |
| `lua/config/plugins/mason.lua` | Reads the `after/lsp/` scan, filters to servers `mason-lspconfig` knows about, installs them. Also installs formatters + DAPs from `tools.lua`. |

## How to add a server

1. Create `after/lsp/<server_name>.lua` (use the LSP server identifier from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/tree/master/lsp), e.g. `gopls`, `vtsls`).
2. Add a doc-link header and return the config table:
   ```lua
   -- foo-language-server
   -- https://github.com/foo/foo-ls
   return {} -- lspconfig supplies cmd/filetypes; only add keys you mean to override
   -- for a server lspconfig does not know:
   -- return { cmd = { "foo-ls" }, filetypes = { "foo" }, root_markers = { ".git" } }
   ```
3. Restart nvim. Mason auto-installs if it knows the server; otherwise install the binary manually.

For minimal customization: `return {}` is enough — nvim-lspconfig ships sensible defaults for 100+ servers.

## External-only servers

Servers Mason can't install (e.g. `nil_ls` from nixpkgs, or a binary you build yourself) still get an `after/lsp/*.lua` file. The Mason filter in `mason.lua` skips them automatically — install the binary yourself.

## Why this works

- `nvim-lspconfig` ships `lsp/<name>.lua` defaults on the runtimepath. Neovim merges all `lsp/<name>.lua` files in runtimepath order, then all `after/lsp/<name>.lua` files (`:h lsp-config-merge`). Our files live in `after/lsp/` so they override lspconfig; in `lsp/` they lost every conflicting key to it.
- `mason-lspconfig.get_mappings()` tells us which LSP names map to Mason packages — we only ask Mason to install ones it knows.
- The pcall guard in `lua/config/lsp/init.lua` isolates failures: one broken `after/lsp/<name>.lua` notifies but doesn't break the rest.

## Related

- [formatting.md](formatting.md) — LSP also handles format-on-save via conform.nvim's `lsp_format = "fallback"`.
- [linting.md](linting.md) — LSP-first linting approach (eslint, vale-ls).
- [completion.md](completion.md) — LSP feeds completion candidates into blink.cmp.
