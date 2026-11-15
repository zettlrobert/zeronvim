# Quickfix and Location lists

## TLDR

Two list types for result sets (grep hits, diagnostics, build errors). **Quickfix** is global to the session; a
**location list** belongs to one window. The commands match; location-list versions start with `l`.

## Workflow

Native quickfix is the spine: populate (`:grep`, `<leader>qd`, telescope `<C-q>`), navigate with `]q`/`[q`, view with
`<leader>qq` or trouble's `<leader>xq`. The location list works the same with `l` commands and `]l`/`[l`.

## Quickfix list

### Navigation

| Keymap | Command | Action |
|---|---|---|
| `]q` | `:cnext` | Next item |
| `[q` | `:cprev` | Previous item |
| `]Q` | `:clast` | Last item |
| `[Q` | `:cfirst` | First item |
| `<A-l>` | `:cnext` | Next (alternative) |
| `<A-h>` | `:cprevious` | Previous (alternative) |

### View

| Keymap | Action |
|---|---|
| `<leader>qq` | Toggle native window (`:copen` / `:cclose`) |
| `<leader>xq` | Toggle in a [trouble][trouble] panel |

The quickfix window's winbar shows its position, e.g. `Quickfix · 3/12`.

### Populate

| Keymap or command | Source |
|---|---|
| `<leader>qd` | All workspace diagnostics (`vim.diagnostic.setqflist()`) |
| `<leader>qe` | Workspace errors only |
| `<leader>qc` | Clear the list (window stays open) |
| `<leader>bj` | DAP breakpoints |
| `:grep <pattern>` | grep results via `grepprg` (Neovim's default: `rg --vimgrep -uu` when `rg` is installed) |
| `:vimgrep /<pat>/ <files>` | Built-in grep across files |
| `:make` | Build or test output |
| Telescope `<C-q>` (in a picker) | Replace the list with all results |
| Telescope `<M-q>` (in a picker) | Replace the list with the selected results |
| Telescope `<C-a>` (in a picker) | Append the selected results (or all, if none selected) and open the list |
| `:TodoQuickFix` | Todo comments |

### Other useful commands

| Command | Action |
|---|---|
| `:cc <n>` | Jump to item `n` |
| `:colder` / `:cnewer` | Previous / next quickfix list (history) |

## Location list

One list per window, versus one quickfix list per session.

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
| `:lopen` / `:lclose` | Open / close native window |
| `<leader>lq` | Populate from the buffer's diagnostics (`vim.diagnostic.setloclist`) |
| `<leader>xl` | Toggle in a [trouble][trouble] panel |
| `:lvimgrep` / `:lgrep` / `:lmake` | `l` versions of the populators |

## Project-wide search and replace with `:cdo`

`:cdo {cmd}` runs `{cmd}` on every quickfix entry. With `:grep` and `:substitute` it gives a native project-wide
replace:

```vim
:grep foo                    " populate quickfix with matches
:cdo s/foo/bar/g | update    " replace in each entry, save each file
:cfdo bd                     " close the opened buffers
```

| Variant | Runs the command |
|---|---|
| `:cdo` | Once per quickfix **entry** |
| `:cfdo` | Once per **file** in the quickfix list |
| `:ldo` / `:lfdo` | Same, for the location list |

## Entry format

The list window shows each entry as:

```text
file|line col| message
```

`:grep`, LSP diagnostics and build output all produce this shape.

## Related

- [linting.md](linting.md) - diagnostics flow into both lists.
- [keymaps.md](keymaps.md) - trouble's `<leader>x*` ("examine") panels are a persistent alternative view.

[trouble]: https://github.com/folke/trouble.nvim
