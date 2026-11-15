# Vale (prose linting)

## TLDR

Vale checks prose against style rules. It runs as the `vale-ls` LSP (see [lsp.md](lsp.md)) but never attaches on its
own: `after/lsp/vale_ls.lua` sets `filetypes = {}`. Attach it to the current buffer when you want a prose pass:
`<leader>tl`, then pick `vale_ls`.

Why on demand: vale-ls diagnostics caused display flicker in editor buffers (e.g. `COMMIT_EDITMSG`, markdown drafts).

## Files

| Path | Role |
|---|---|
| `after/lsp/vale_ls.lua` | LSP config: `cmd = { "vale-ls" }`, `root_markers = { ".vale.ini", "_vale.ini", ".git" }`, no filetypes |
| `~/.vale.ini` or `<project>/.vale.ini` | Vale's config: style packages, alert level, exclusions |
| `<project>/styles/` | Style packages, filled by `vale sync` |

## Setup (once per project)

Vale reports nothing without a `.vale.ini` in the project root or an ancestor. Minimal config:

```ini
# .vale.ini
StylesPath = styles

MinAlertLevel = suggestion

Packages = Google, write-good

[*.md]
BasedOnStyles = Vale, Google, write-good
```

Download the packages:

```bash
vale sync
```

This fills `styles/` with `Google/`, `write-good/` and so on. Git-ignore that directory.

## Common style packages

| Package | Focus | Notes |
|---|---|---|
| `Vale` | Built-in core checks (spelling, repetition) | On by default |
| `Google` | [Google developer docs style guide](https://developers.google.com/style) | Strict. Common noise: `Google.Acronyms`, `Google.EmDash`, `Google.WordList` |
| `Microsoft` | [Microsoft Writing Style Guide](https://learn.microsoft.com/style-guide/) | Like Google, slightly looser |
| `write-good` | Passive voice, wordiness | Less prescriptive |
| `proselint` | [proselint](https://github.com/amperser/proselint) rules: clichés, jargon | Opinionated |
| `alex` | Inclusive language | Flags possibly insensitive wording |

## Tuning noisy rules

| Scope | How |
|---|---|
| **Block** | `<!-- vale Google.EmDash = NO -->` before, `<!-- vale Google.EmDash = YES -->` after (markdown) |
| **File** | The `= NO` comment at the top of the file |
| **Project** | `Google.EmDash = NO` under `[*.md]` in `.vale.ini` |

Since vale-ls is on demand, the simplest escape hatch is to leave it detached.

## Toggle keymaps

| Key | Action |
|---|---|
| `<leader>tl` | LSP picker over every server in `after/lsp/` |
| `<leader>tv` | Flip vale_ls's persisted on/off state |

Picker states and what selecting does:

| Marker | State | Selecting it |
|---|---|---|
| `○` | not attached | Attach to this buffer only |
| `●` | attached | Turn off everywhere, persisted |
| `✕` | disabled (persisted) | Turn on everywhere and attach here |

Persisted state lives in `~/.local/state/nvim/lsp-toggles.json` and survives restarts.

`<leader>tv` calls `toggle_lsp_server("vale_ls")` from `lua/config/utils/lsp_toggle.lua`. It flips the persisted state,
not the attachment. vale_ls starts "on" (enabled, but with no filetypes), so the first press disables it and nothing
visible changes. The second press enables it and attaches to the current buffer. Prefer the picker for a one-off pass.

The helper works for any server. To bind one for another noisy LSP:

```lua
vim.keymap.set("n", "<leader>te", function()
  require("config.utils").toggle_lsp_server("eslint")
end, { desc = keymap_desc.format(KIND.TOGGLE, TOOL.LSP, "eslint") })
```

## Suggested workflow

1. Configure `Google` + `write-good` in `.vale.ini` at user or project level.
2. Silence consistently noisy rules in `.vale.ini`. Project-wide keeps a team aligned.
3. Draft with vale detached. To polish: `<leader>tl`, pick `vale_ls`. To finish: pick it again (this turns it off and
   persists that).

## Related

- [lsp.md](lsp.md) - vale-ls follows the standard `after/lsp/<name>.lua` pattern.
- [linting.md](linting.md) - LSP-first linting overview.
- [nvim-lists.md](nvim-lists.md) - send vale diagnostics to the loclist (`<leader>lq`) or quickfix (`<leader>qd`).

## References

- Vale: <https://vale.sh>
- vale-ls: <https://github.com/errata-ai/vale-ls>
- Style package registry: <https://vale.sh/explorer>
- Config reference: <https://vale.sh/docs/topics/config>
