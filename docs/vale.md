# Vale (prose linting)

## TLDR

Vale checks prose for grammar, style, and writing conventions across `markdown`, `text`, `tex`, `rst`, and `mdx`. Wired as `vale-ls` LSP (see [lsp.md](lsp.md)), diagnostics surface like any other LSP warning. Toggle per-buffer with `<leader>tv` when the configured rules fight your writing style.

## Files

| Path | Role |
|---|---|
| `lsp/vale_ls.lua` | LSP config — filetypes, root markers, no special settings (vale-ls reads `.vale.ini` from the project root) |
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
| **Per-buffer (session)** | `<leader>tv` — detach vale-ls from the current buffer |

The toggle keymap is the right escape hatch when you're drafting something where the noise outweighs the signal, but you don't want to permanently silence the rule.

## Toggle keymap

| Keymap | Action |
|---|---|
| `<leader>tv` | Toggle `vale_ls` attach/detach on the current buffer |

Implementation: `M.toggle_server(name)` in `lua/config/lsp/init.lua`. Generic — bind it for other noisy LSPs too:

```lua
vim.keymap.set("n", "<leader>te", function()
  require("config.lsp").toggle_server("eslint")
end, { desc = "Toggle eslint in current buffer" })
```

## Suggested workflow

1. Keep `Google` + `write-good` enabled at the user/project level — they catch real issues.
2. Silence the few rules that consistently produce noise in your writing via `.vale.ini` overrides (project-wide is best — keeps the team aligned).
3. Use `<leader>tv` when you're heads-down drafting and even good rules slow you down. Re-toggle when you're ready to polish.

## Related

- [lsp.md](lsp.md) — vale-ls follows the standard `lsp/<name>.lua` pattern.
- [linting.md](linting.md) — broader LSP-first linting overview.
- [nvim-lists.md](nvim-lists.md) — vale diagnostics flow into the loclist via `<space>lq` and the quickfix via `<leader>qd`.

## References

- Vale homepage: <https://vale.sh>
- vale-ls: <https://github.com/errata-ai/vale-ls>
- Style package registry: <https://vale.sh/explorer>
- Config reference: <https://vale.sh/docs/topics/config>
