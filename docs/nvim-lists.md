# Quickfix and Location lists

## TLDR

Two list types for navigating result sets (grep hits, lint diagnostics, compile errors). **Quickfix** is global to the Vim session, **location** is local to a window. Same commands, location-list versions are prefixed with `l`.

## Quickfix list

| Command | Action |
|---|---|
| `:copen` | Open the quickfix window |
| `:cclose` / `:ccl` | Close the window |
| `:cnext` / `:cn` | Next item |
| `:cprev` / `:cp` | Previous item |
| `:cfirst` | First item |
| `:clast` | Last item |
| `:cc <n>` | Jump to item `n` |

Keymapped: `<A-l>` → `:cnext`, `<A-h>` → `:cprev` (see `lua/config/keymaps.lua`).

## Location list

Window-local. Up to one list per window (vs one global quickfix list per session).

| Command | Action |
|---|---|
| `:lopen` | Open the location window |
| `:lclose` / `:lcl` | Close |
| `:lnext` / `:lprev` | Next / previous |
| `:lfirst` / `:llast` | First / last |
| `:ll <n>` | Jump to item `n` |

Populate with `l`-prefixed commands: `:lvimgrep`, `:lmake`, `:lgrep`. Many plugins (LSP loclist via `<space>lq`, e.g.) write here by default.

## Navigating older lists

Vim retains up to 10 quickfix lists per session, 10 location lists per window. New operations push a new list; older ones stay accessible.

| Command | Action |
|---|---|
| `:colder` / `:col` | Previous quickfix list |
| `:cnewer` / `:cnew` | Next quickfix list |
| `:lolder` / `:lol` | Previous location list |
| `:lnewer` / `:lnew` | Next location list |

## Project-wide search-and-replace via `:cdo`

`:cdo {cmd}` runs `{cmd}` on every quickfix entry. Combined with `:grep` and `:substitute`, this is the closest thing to a native project-wide replace.

```vim
:grep foo            " populate quickfix with matches
:cdo s/foo/bar/g | update    " replace in each, save each
:cfdo bd             " close opened buffers
```

| Variant | Behavior |
|---|---|
| `:cdo` | Run command for each quickfix **entry** |
| `:cfdo` | Run command once per **file** referenced in quickfix |
| `:ldo` / `:lfdo` | Same, for the location list |

## Format

```
file | row | col | error message
```

Anything that writes to these lists follows this shape.

## Related

- [linting.md](linting.md) — diagnostics can be sent to the loclist via `<space>lq`.
