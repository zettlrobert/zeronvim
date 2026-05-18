# Quickfix and Location lists

## TLDR

Two list types for navigating result sets (grep hits, lint diagnostics, compile errors). **Quickfix** is global to the Vim session, **location** is local to a window. Same commands, location-list versions are prefixed with `l`.

## Workflow

Native quickfix is the spine: `:grep` (or any populator) → navigate with `]q`/`[q` → optionally view with `:copen` or trouble's `<leader>xq`. The same shape applies to the location list with `l`-prefixed commands and `]l`/`[l`.

## Quickfix list

### Navigation

| Keymap | Command | Action |
|---|---|---|
| `]q` | `:cnext` | Next item |
| `[q` | `:cprev` | Previous item |
| `]Q` | `:clast` | Last item |
| `[Q` | `:cfirst` | First item |
| `<A-l>` | `:cnext` | Next (alternative) |
| `<A-h>` | `:cprev` | Previous (alternative) |

### View

| Keymap | Action |
|---|---|
| `<leader>qq` | Toggle native window (`:copen` / `:cclose`) |
| `<leader>xq` | Toggle in trouble panel ([see trouble][trouble]) |

### Populate

| Keymap | Source |
|---|---|
| `<leader>qd` | All workspace diagnostics (`vim.diagnostic.setqflist()`) |
| `<leader>qe` | Workspace errors only |
| `:grep <pattern>` | grep results (uses `grepprg`, default `rg` via `:set grepprg`) |
| `:vimgrep /<pat>/ <files>` | Internal grep across files |
| `:make` | Build/test runner output |
| Telescope `<C-q>` (inside picker) | Send current picker results to qflist |
| Telescope `<M-q>` (inside picker) | Send only selected results to qflist |
| `:TodoQuickFix` | Todo-comments matches |

### Other useful commands

| Command | Action |
|---|---|
| `:cc <n>` | Jump to item `n` |
| `:colder` / `:cnewer` | Previous / next quickfix list (history) |

## Location list

Window-local. Up to one list per window (vs one global quickfix list per session).

### Navigation

| Keymap | Command | Action |
|---|---|---|
| `]l` | `:lnext` | Next item |
| `[l` | `:lprev` | Previous item |
| `]L` | `:llast` | Last item |
| `[L` | `:lfirst` | First item |

### View / populate

| Keymap or command | Action |
|---|---|
| `:lopen` / `:lclose` | Toggle native window |
| `<space>lq` | Populate from LSP buffer diagnostics (`vim.diagnostic.setloclist`) |
| `<leader>xl` | Toggle in trouble panel ([see trouble][trouble]) |
| `:lvimgrep` / `:lgrep` / `:lmake` | `l`-prefixed populators |

## Project-wide search-and-replace via `:cdo`

`:cdo {cmd}` runs `{cmd}` on every quickfix entry. Combined with `:grep` and `:substitute`, this is the closest thing to a native project-wide replace.

```vim
:grep foo               " populate quickfix with matches
:cdo s/foo/bar/g | update    " replace in each, save each
:cfdo bd                " close opened buffers
```

| Variant | Behavior |
|---|---|
| `:cdo` | Run command for each quickfix **entry** |
| `:cfdo` | Run command once per **file** referenced in quickfix |
| `:ldo` / `:lfdo` | Same, for the location list |

## Entry format

```
file | row | col | error message
```

Anything that writes to these lists follows this shape (used by `:grep`, LSP diagnostics, build output, etc.).

## Related

- [linting.md](linting.md) — diagnostics flow into both lists.
- trouble.nvim provides an alternative persistent split panel; bindings under `<leader>x*` ("examine").

[trouble]: https://github.com/folke/trouble.nvim
