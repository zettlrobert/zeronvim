# Keymaps

## TLDR

Every keymap in this config, grouped by `<leader>*` namespace. Discovery: press `<leader>` and wait ~250ms — which-key shows the namespace popup. Search by description: `<leader>fk` (telescope keymaps picker). Full list: `:map <leader>` or `:Telescope keymaps`.

Namespaces at a glance:

| Prefix | Domain |
|---|---|
| `<leader>a` | AI (CodeCompanion + Copilot/Windsurf/Minuet toggles) |
| `<leader>b` | Debug (DAP runtime ops) |
| `<leader>c` | Copy (buffer paths) |
| `<leader>d` | Diagnostic float (single-key) |
| `<leader>e` | Explorer (nvim-tree) |
| `<leader>f` | Find (telescope) |
| `<leader>g` | Git |
| `<leader>l` | LSP |
| `<leader>m` | Markdown |
| `<leader>n` | Notifications |
| `<leader>P` | Persistence (session restore) |
| `<leader>q` | Quickfix |
| `<leader>r` | Review (planned) |
| `<leader>R` | REST / HTTP (kulala) |
| `<leader>s` | Symbols |
| `<leader>t` | Toggle |
| `<leader>T` | Test (neotest) |
| `<leader>x` | eXamine (trouble) |

## `<leader>a` — AI

| Key | Action |
|---|---|
| `<leader>ac` | CodeCompanion chat toggle |
| `<leader>aa` | CodeCompanion actions palette |
| `<leader>ap` | Toggle Copilot (global on/off) |
| `<leader>aw` | Toggle Windsurf / Codeium (global on/off) |
| `<leader>am` | Toggle Minuet local AI completion |
| `<leader>aA` | Toggle all AI providers at once |

All completion providers start disabled at nvim startup — see `docs/ai.md`.

## `<leader>b` — Debug (DAP runtime ops)

UI toggles moved to `<leader>tdv`/`<leader>tdu` under the toggle group.

| Key | Action |
|---|---|
| `<leader>bb` | Toggle breakpoint at cursor |
| `<leader>bB` | Set conditional breakpoint (prompt) |
| `<leader>bc` | Continue / start session |
| `<leader>bi` | Step into |
| `<leader>bo` | Step over |
| `<leader>bO` | Step out |
| `<leader>br` | Toggle REPL |
| `<leader>bl` | Run last configuration |
| `<leader>bx` | Terminate session (eXit) |
| `<leader>bj` | List breakpoints in quickfix |
| `<leader>bw` | Add expression to watches |

## `<leader>c` — Copy (buffer paths)

| Key | Action |
|---|---|
| `<leader>cr` | Relative buffer path → `r` register |
| `<leader>ca` | Absolute buffer path → `a` register |
| `<leader>cA` | Absolute buffer path with CWD → system clipboard |

## `<leader>d` — Diagnostic

| Key | Action |
|---|---|
| `<leader>d` | Diagnostic float at cursor (single-key) |

## `<leader>e` — Explorer (nvim-tree)

| Key | Action |
|---|---|
| `<leader>e` | Toggle nvim-tree |
| `<leader>ef` | Reveal current file in tree |

## `<leader>f` — Find (telescope)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fF` | Find files including hidden |
| `<leader>fb` | Buffers |
| `<leader>fl` | Live grep |
| `<leader>fg` | Custom multigrep (space-separated: pattern + glob) |
| `<leader>fh` | Help tags |
| `<leader>fr` | LSP references |
| `<leader>fd` | LSP definitions |
| `<leader>fD` | Workspace diagnostics |
| `<leader>fk` | **Keymaps picker** (search by desc) |
| `<leader>fn` | Nvim config files |
| `<leader>fp` | Installed plugin files |

Inside any picker: `<C-q>` sends all results to qflist (REPLACE), `<C-a>` appends to qflist (ACCUMULATE across searches).

## `<leader>g` — Git

| Key | Action |
|---|---|
| `<leader>gD` | Diffview open (mnemonic: **D**iff) |
| `<leader>gC` | Diffview close (mnemonic: **C**lose) |
| `<leader>gb` | Toggle current-line blame |
| `<leader>gw` | Toggle word diff |
| `<leader>gh` | Hunk diff current file |

## `<leader>l` — LSP

| Key | Action |
|---|---|
| `<leader>la` | LSP actions menu (categorized picker) |
| `<leader>lc` | Code action (direct) |
| `<leader>lf` | Format buffer |
| `<leader>lr` | Rename symbol |
| `<leader>lq` | Diagnostics → loclist |

Native Neovim 0.11+ LSP defaults also available: `gd` (definition), `grn` (rename), `gra` (code action), `grr` (references), `gri` (implementation), `gO` (document symbols), `K` (hover).

## `<leader>m` — Markdown

| Key | Action |
|---|---|
| `<leader>mr` | Toggle render-markdown for current buffer |

## `<leader>n` — Notifications

| Key | Action |
|---|---|
| `<leader>nh` | Show snacks.notifier history (equivalent of `:messages` for `vim.notify` calls) |

## `<leader>P` — Persistence (session restore)

| Key | Action |
|---|---|
| `<leader>Ps` | Restore session for current cwd |
| `<leader>Pl` | Restore last session (any cwd) |
| `<leader>Pd` | Stop autosaving this session |

Sessions auto-save on `VimLeavePre`. Restore is manual — dashboard also exposes `s` as a quick action.

## `<leader>q` — Quickfix

| Key | Action |
|---|---|
| `<leader>qq` | Toggle quickfix window |
| `<leader>qd` | Populate with all workspace diagnostics |
| `<leader>qe` | Populate with workspace errors only |
| `<leader>qc` | Clear the quickfix list (window stays open) |

## `<leader>r` — Review

Planned. Empty for now.

## `<leader>R` — REST / HTTP (kulala plugin defaults)

Kulala installs `<leader>R{o,b,q,c,C,i,j,e,u,r,s,a,g,n,p,f,t,S,x,X}`. See `:help kulala` or `:MasonLog kulala` for the full list.

## `<leader>s` — Symbols

| Key | Action |
|---|---|
| `<leader>ss` | Navbuddy (LSP symbol tree) |

## `<leader>t` — Toggle

| Key | Action |
|---|---|
| `<leader>th` | Toggle search highlight |
| `<leader>ts` | Toggle spellcheck |
| `<leader>tv` | Toggle vale-ls (prose linting) |
| `<leader>tl` | Toggle any LSP server (picker) |
| `<leader>tz` | Toggle zen mode |
| `<leader>tc` | Toggle color picker (ccc) |
| `<leader>tm` | Toggle markdownlint (via `toggle_linter` util) |
| `<leader>tdv` | Toggle debug view (dap-view) |
| `<leader>tdu` | Toggle debug ui (dap-ui) |

## `<leader>T` — Test (neotest)

| Key | Action |
|---|---|
| `<leader>Tt` | Run nearest test |
| `<leader>Tf` | Run all tests in file |
| `<leader>Td` | **Debug** nearest test (DAP session) |
| `<leader>To` | Open test output |
| `<leader>Ts` | Toggle summary panel |

## `<leader>x` — eXamine (trouble)

| Key | Action |
|---|---|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xq` | Quickfix in trouble panel |
| `<leader>xl` | Loclist in trouble panel |
| `<leader>xs` | Symbols |
| `<leader>xr` | LSP defs/refs |
| `<leader>xt` | Todos |

## Single-key `<leader>`

| Key | Action |
|---|---|
| `<leader>d` | Diagnostic float |
| `<leader>e` | Nvim-tree toggle |
| `<leader>u` | Undotree toggle |
| `<leader>y` | Yank to system clipboard (n/v) |
| `<leader>p` | Paste without losing buffer (x); paste image (n, img-clip) |
| `<leader>?` | Which-key buffer keymaps |
| `<leader>.` | New / toggle scratch buffer (snacks.scratch, per-cwd persistent) |
| `<leader>S` | Pick from saved scratch buffers for current cwd |
| `<leader>x` | Execute current line as Lua (`<leader><leader>x` runs the whole file) |

## Non-`<leader>` keymaps

### Window navigation

| Key | Action |
|---|---|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move cursor to left/lower/upper/right window |
| `<C-Up>` `<C-Down>` | Decrease / increase vertical window size |
| `<C-Left>` `<C-Right>` | Decrease / increase horizontal window size |

### Motion (page)

| Key | Action |
|---|---|
| `<C-d>` `<C-u>` | Page down / up (recentered with `zz`) |

### Motion (flash)

| Key | Action |
|---|---|
| `s` (n/x/o) | Flash jump |
| `S` (n/x/o) | Flash treesitter jump |
| `r` (o) | Remote flash |
| `R` (o/x) | Treesitter search |
| `<C-s>` (c) | Toggle flash in cmdline search |

### Quickfix / loclist navigation

| Key | Action |
|---|---|
| `]q` `[q` | Next / previous quickfix item |
| `]Q` `[Q` | Last / first quickfix item |
| `]l` `[l` | Next / previous loclist item |
| `]L` `[L` | Last / first loclist item |
| `<A-l>` `<A-h>` | Next / previous quickfix (alt binding) |

### Diagnostic navigation

| Key | Action |
|---|---|
| `]d` `[d` | Next / previous diagnostic (Neovim 0.12 native `vim.diagnostic.jump`) |

### Todo navigation

| Key | Action |
|---|---|
| `]t` `[t` | Next / previous todo comment |

### Line movement

| Key | Action |
|---|---|
| `<A-j>` `<A-k>` | Move current line down / up (also works in visual mode for selection) |

### Indentation

| Key | Action |
|---|---|
| `<` `>` (v) | Decrease / increase indent (preserves visual selection) |

### Explorer

| Key | Action |
|---|---|
| `-` (n) | Open Oil (parent directory) |

### LSP actions picker (also VS Code muscle memory)

| Key | Action |
|---|---|
| `<C-.>` (n/v) | LSP actions menu (categorized picker) |

## Filetype-scoped

### Markdown

| Key | Action |
|---|---|
| `j` `k` | Screen-line motion (respects wrap) |

## Related

- [lsp.md](lsp.md) — LSP architecture
- [debugging.md](debugging.md) — DAP setup
- [nvim-lists.md](nvim-lists.md) — quickfix / loclist detail
