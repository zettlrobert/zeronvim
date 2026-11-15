# LSP

## TLDR

The filenames in `after/lsp/` are the single source of truth for `vim.lsp.enable()` and for Mason's install list. Add a
file to add a server; delete it to remove one. There is no central list.

## Files

| Path | Role |
|---|---|
| `after/lsp/<name>.lua` | Per-server config, merged over the nvim-lspconfig defaults. `return {}` keeps the defaults. |
| `lua/config/lsp/init.lua` | Scans `after/lsp/`, calls `vim.lsp.enable` per server inside `pcall`. Sets diagnostics config, LspAttach (completion, navic, navbuddy) and `<leader>d`/`<leader>lc`/`<leader>lq`. |
| `lua/config/lsp/tools.lua` | Mason lists for formatters, linters and debug adapters. LSP servers are not listed here. |
| `lua/config/lsp/vue.lua` | Vue workspace detection: `tsc` skips Vue workspaces, `vtsls` + `vue_ls` take them. |
| `lua/config/plugins/mason.lua` | Installs the scanned servers that mason-lspconfig knows, plus everything in `tools.lua`. `automatic_enable = false`. |
| `lua/config/utils/lsp_toggle.lua` | Persisted per-server on/off (`<leader>tl` picker, `<leader>tv` for vale_ls). |

## How to add a server

1. Create `after/lsp/<server_name>.lua`. Use the name from
   [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/tree/master/lsp), e.g. `gopls`, `vtsls`.
2. Add a doc-link header and return the config:

   ```lua
   -- foo-language-server
   -- https://github.com/foo/foo-ls
   return {} -- lspconfig supplies cmd/filetypes; add only the keys you override
   -- for a server lspconfig does not know:
   -- return { cmd = { "foo-ls" }, filetypes = { "foo" }, root_markers = { ".git" } }
   ```

3. Restart nvim. Mason installs the server if it has a package; otherwise install the binary yourself.

## Servers Mason cannot install

Servers like `nil_ls` (from nixpkgs) or a binary you build still get an `after/lsp/*.lua` file. `mason.lua` drops names
that mason-lspconfig cannot map to a package, so install those binaries yourself.

## Turning a server off

`<leader>tl` opens a picker over every configured server. Turning one off calls `vim.lsp.enable(name, false)` and saves
the name to `~/.local/state/nvim/lsp-toggles.json`. At startup `lsp/init.lua` skips saved names, so the server stays off
after a restart. See [vale.md](vale.md) for the picker states.

## Why this works

- nvim-lspconfig ships defaults as `lsp/<name>.lua` on the runtimepath. Neovim merges every `lsp/<name>.lua` in
  runtimepath order, then every `after/lsp/<name>.lua` (`:h lsp-config-merge`). Files in `after/lsp/` therefore win; in
  `lsp/` they lost every conflicting key to lspconfig.
- mason-lspconfig's `lspconfig_to_package` mapping tells `mason.lua` which names have a Mason package.
- The `pcall` in `lua/config/lsp/init.lua` isolates failures: one broken file notifies with a warning, the rest still
  load.

## Related

- [formatting.md](formatting.md) - LSP formatting is conform's fallback.
- [linting.md](linting.md) - LSP-based linters (eslint, vale-ls, tflint).
- [completion.md](completion.md) - LSP feeds candidates into blink.cmp.
