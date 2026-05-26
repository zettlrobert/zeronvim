# Vale (prose linting)

## TLDR

Vale checks prose for grammar, style, and writing conventions. Wired as `vale-ls` LSP (see [lsp.md](lsp.md)) but **opt-in** — it never auto-attaches. Press `<leader>tv` to attach it to the current buffer when you want a prose pass; `<leader>tv` again to detach.

Reason for opt-in: vale-ls diagnostics caused display flicker in editor buffers (e.g. `COMMIT_EDITMSG`, markdown drafts). Manual attach keeps it out of the way unless you've decided to invoke it.

## Files

| Path | Role |
|---|---|
| `lsp/vale_ls.lua` | LSP config — registered with empty filetypes so it never auto-attaches; vale-ls reads `.vale.ini` from the project root when invoked |
| `~/.vale.ini` or `<project>/.vale.ini` | Vale's own config — picks which style packages to apply, severity levels, exclusions |
| `<project>/styles/` | Style package directory — populated by `vale sync` |

## Setup (one-time per project)

Vale only emits diagnostics when it finds a `.vale.ini` in the project root or an ancestor. Minimal setup:

```ini
# .vale.ini
StylesPath = styles

MinAlertLevel = suggestion

Packages = Google, write-good

[*.md]
BasedOnStyles = Vale, Google, write-good
```

Then download the rule packages:

```bash
vale sync
```

This populates `styles/` with `Google/`, `write-good/`, etc. — git-ignore that directory.

## Common style packages

| Package | Focus | Notes |
|---|---|---|
| `Vale` | Built-in core checks (spelling, repetition) | Always on by default |
| `Google` | [Google developer docs style guide](https://developers.google.com/style) | Strict, opinionated. Common noise: `Google.Acronyms`, `Google.EmDash`, `Google.WordList` |
| `Microsoft` | [Microsoft Writing Style Guide](https://learn.microsoft.com/style-guide/) | Similar to Google, slightly looser |
| `write-good` | Common writing weaknesses (passive voice, wordiness) | Less prescriptive |
| `proselint` | [proselint](https://github.com/amperser/proselint) rules — clichés, jargon | Curated, opinionated |
| `alex` | Inclusive language checks | Flags potentially insensitive wording |

## Tuning noisy rules

Vale flags everything matched by the active rules. When `Google.Acronyms` complains every time you write `LSP` or `Google.EmDash` flags every `—`, you have three options ranked by scope:

| Scope | How |
|---|---|
| **Per-line** | Append `<!-- vale Google.EmDash = NO -->` before, `<!-- vale Google.EmDash = YES -->` after — works in markdown |
| **Per-file** | Add the comment at the top of the file |
| **Per-project** | In `.vale.ini`, set `Google.EmDash = NO` under the `[*.md]` section |

Since vale-ls is opt-in (manual attach via `<leader>tv`), the everyday "just turn it off" escape hatch is to not attach it in the first place. Only attach when you want a deliberate prose pass.

## Toggle keymap

| Keymap | Action |
|---|---|
| `<leader>tv` | Attach vale-ls to the current buffer (or detach if already attached) |
| `<leader>tl` | Generic LSP picker — pick any server to toggle, including vale-ls |

Implementation: `toggle_lsp_server(name)` in `lua/config/utils/toggle_lsp_server.lua`, exposed as `require("config.utils").toggle_lsp_server`. Generic — bind it for other noisy LSPs too:

```lua
vim.keymap.set("n", "<leader>te", function()
  require("config.utils").toggle_lsp_server("eslint")
end, { desc = "Toggle eslint in current buffer" })
```

## Suggested workflow

1. Configure `Google` + `write-good` in `.vale.ini` at the user/project level — they're what fires when you do invoke vale.
2. Silence the few rules that consistently produce noise via `.vale.ini` overrides (project-wide is best — keeps the team aligned).
3. Draft normally with vale detached (default). When ready to polish, `<leader>tv` to attach for a prose pass. `<leader>tv` again when done.

## Related

- [lsp.md](lsp.md) — vale-ls follows the standard `lsp/<name>.lua` pattern.
- [linting.md](linting.md) — broader LSP-first linting overview.
- [nvim-lists.md](nvim-lists.md) — vale diagnostics flow into the loclist via `<space>lq` and the quickfix via `<leader>qd`.

## References

- Vale homepage: <https://vale.sh>
- vale-ls: <https://github.com/errata-ai/vale-ls>
- Style package registry: <https://vale.sh/explorer>
- Config reference: <https://vale.sh/docs/topics/config>
