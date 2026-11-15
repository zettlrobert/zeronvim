# Keymaps

## TLDR

Every keymap in this config, grouped by `<leader>*` namespace. `<leader>` is Space.

- Discover: press `<leader>` and wait. which-key shows the namespace popup.
- Search by description: `<leader>fk` (telescope keymaps picker).
- Full list: `:map <leader>`.

Almost all keymaps live in `lua/config/keymaps.lua`. Exceptions:

| File | Keymaps |
|---|---|
| `lua/config/lsp/init.lua` | `<leader>d`, `<leader>lc`, `<leader>lq` |
| `lua/config/utils/source.lua` | `<leader>x`, `<leader><leader>x` |
| `lua/config/plugins/comment.lua` | `gc`, `gb` and the Comment.nvim extras |
| `lua/config/plugins/kulala.lua` | `<leader>R*` (kulala creates them) |
| `after/ftplugin/markdown.lua` | buffer-local `j`, `k` |

| Prefix | Domain |
|---|---|
| `<leader>a` | AI (CodeCompanion, Copilot and Minuet toggles) |
| `<leader>b` | Debug (DAP runtime ops) |
| `<leader>c` | Copy (buffer paths) |
| `<leader>d` | Diagnostic float (single key) |
| `<leader>e` | Explorer (nvim-tree) |
| `<leader>f` | Find (telescope) |
| `<leader>g` | Git |
| `<leader>l` | LSP |
| `<leader>m` | Markdown |
| `<leader>n` | Notifications |
| `<leader>P` | Persistence (session restore) |
| `<leader>q` | Quickfix |
| `<leader>r` | Review (planned, empty) |
| `<leader>R` | REST / HTTP (kulala) |
| `<leader>s` | Symbols |
| `<leader>t` | Toggle |
| `<leader>T` | Test (neotest) |
| `<leader>x` | eXamine (trouble) |

## `<leader>a`: AI

| Key | Action |
|---|---|
| `<leader>ac` | Toggle CodeCompanion chat |
| `<leader>aa` | CodeCompanion actions palette |
| `<leader>ap` | Toggle Copilot (global) |
| `<leader>am` | Toggle Minuet local AI completion |
| `<leader>aA` | Toggle all AI providers at once |

Copilot and Minuet start disabled. See [ai.md](ai.md).

## `<leader>b`: Debug (DAP)

UI toggles live under `<leader>td*`. See [debugging.md](debugging.md).

| Key | Action |
|---|---|
| `<leader>bb` | Toggle breakpoint at cursor |
| `<leader>bB` | Conditional breakpoint (prompt) |
| `<leader>bc` | Continue / start session |
| `<leader>bi` | Step into |
| `<leader>bo` | Step over |
| `<leader>bO` | Step out |
| `<leader>br` | Toggle REPL |
| `<leader>bl` | Run last configuration |
| `<leader>bx` | Terminate session (eXit) |
| `<leader>bj` | List breakpoints in quickfix |
| `<leader>bw` | Add expression to watches |

## `<leader>c`: Copy (buffer paths)

| Key | Action |
|---|---|
| `<leader>cr` | Relative buffer path to register `r` |
| `<leader>ca` | Absolute buffer path to register `a` |
| `<leader>cA` | Absolute buffer path with CWD to system clipboard |

## `<leader>e`: Explorer (nvim-tree)

| Key | Action |
|---|---|
| `<leader>e` | Toggle nvim-tree |
| `<leader>ef` | Reveal current file in tree |

## `<leader>f`: Find (telescope)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>f.` | Find files, including hidden |
| `<leader>fb` | Buffers |
| `<leader>fl` | Live grep |
| `<leader>fg` | Multigrep: pattern, then two spaces, then a glob |
| `<leader>fh` | Help tags |
| `<leader>fr` | LSP references |
| `<leader>fd` | LSP definitions |
| `<leader>fD` | Diagnostics |
| `<leader>fk` | Keymaps picker (search by desc) |
| `<leader>fn` | Nvim config files |
| `<leader>fp` | Installed plugin files |

Inside any picker: `<C-q>` replaces the quickfix list with the results, `<C-a>` appends to it.

## `<leader>g`: Git

| Key | Action |
|---|---|
| `<leader>gD` | Open Diffview |
| `<leader>gC` | Close Diffview |
| `<leader>gb` | Toggle current-line blame |
| `<leader>gw` | Toggle word diff |
| `<leader>gh` | Diff current file against the index (gitsigns `diffthis`) |

## `<leader>l`: LSP

| Key | Action |
|---|---|
| `<leader>la` | LSP actions menu (categorized picker) |
| `<leader>lc` | Code action (direct) |
| `<leader>lf` | Format buffer through conform (see [formatting.md](formatting.md)) |
| `<leader>lr` | Rename symbol |
| `<leader>lq` | Diagnostics to loclist |

Neovim's built-in LSP defaults also work: `grn` (rename), `gra` (code action), `grr` (references), `gri`
(implementation), `gO` (document symbols), `K` (hover).

## `<leader>m`: Markdown

| Key | Action |
|---|---|
| `<leader>mr` | Toggle render-markdown for current buffer |

## `<leader>n`: Notifications

| Key | Action |
|---|---|
| `<leader>nh` | snacks.notifier history (`:messages` for `vim.notify`) |

## `<leader>P`: Persistence (sessions)

| Key | Action |
|---|---|
| `<leader>Ps` | Restore session for current cwd |
| `<leader>Pl` | Restore last session (any cwd) |
| `<leader>Pd` | Stop autosaving this session |

Sessions save on `VimLeavePre` once persistence has loaded (first file read). Restore is manual. The dashboard also
offers `s` to restore.

## `<leader>q`: Quickfix

| Key | Action |
|---|---|
| `<leader>qq` | Toggle quickfix window |
| `<leader>qd` | Populate with all workspace diagnostics |
| `<leader>qe` | Populate with workspace errors only |
| `<leader>qc` | Clear the list (window stays open) |

## `<leader>R`: REST / HTTP (kulala)

Kulala creates its own `<leader>R*` maps (`global_keymaps = true`). Three load the plugin before first use:

| Key | Action |
|---|---|
| `<leader>Rs` | Send request |
| `<leader>Ra` | Send all requests |
| `<leader>Rb` | Open scratchpad |

Full list: `:help kulala`, or press `<leader>R` and wait for which-key.

## `<leader>s`: Symbols

| Key | Action |
|---|---|
| `<leader>ss` | Navbuddy (LSP symbol tree) |

## `<leader>t`: Toggle

| Key | Action |
|---|---|
| `<leader>th` | Search highlight |
| `<leader>ts` | Spellcheck |
| `<leader>tv` | vale-ls prose linting (see [vale.md](vale.md)) |
| `<leader>tl` | Any LSP server (picker) |
| `<leader>tz` | Zen mode |
| `<leader>tc` | Color picker (`:CccPick`) |
| `<leader>tm` | markdownlint-cli2 linter |
| `<leader>tdv` | Debug view (nvim-dap-view) |
| `<leader>tdu` | Debug UI (nvim-dap-ui) |

## `<leader>T`: Test (neotest)

| Key | Action |
|---|---|
| `<leader>Tt` | Run nearest test |
| `<leader>Tf` | Run all tests in file |
| `<leader>Td` | Debug nearest test (DAP session) |
| `<leader>To` | Open test output |
| `<leader>Ts` | Toggle summary panel |

## `<leader>x`: eXamine (trouble)

| Key | Action |
|---|---|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xq` | Quickfix |
| `<leader>xl` | Loclist |
| `<leader>xs` | Symbols |
| `<leader>xr` | LSP definitions and references |
| `<leader>xt` | Todos |

## Single-key `<leader>`

| Key | Action |
|---|---|
| `<leader>d` | Diagnostic float at cursor |
| `<leader>e` | Toggle nvim-tree |
| `<leader>u` | Toggle undotree |
| `<leader>y` | Yank to system clipboard (n/v) |
| `<leader>p` | n: paste image from clipboard (img-clip). x: paste over selection, keep the register |
| `<leader>-` | Oil in a float |
| `<leader>?` | which-key, buffer-local keymaps only |
| `<leader>.` | Toggle the scratch buffer for this cwd (snacks.scratch, persistent) |
| `<leader>S` | Pick a saved scratch buffer for this cwd |
| `<leader>x` | Execute current line (n) or selection (v) as Lua |
| `<leader><leader>x` | Source the current file |

`<leader>x` is also the trouble prefix, so it fires only after the which-key timeout.

## Non-`<leader>` keymaps

| Key | Mode | Action |
|---|---|---|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | n | Move to left/lower/upper/right window |
| `<C-Up>` `<C-Down>` | n | Decrease / increase window height |
| `<C-Left>` `<C-Right>` | n | Decrease / increase window width |
| `<C-d>` `<C-u>` | n | Page down / up, recentered (`zz`) |
| `s` | n/x/o | Flash jump |
| `S` | n/x/o | Flash treesitter node |
| `r` | o | Flash remote |
| `R` | o/x | Flash treesitter search |
| `<C-s>` | c | Toggle flash labels in `/` search |
| `]q` `[q` | n | Next / previous quickfix item |
| `]Q` `[Q` | n | Last / first quickfix item |
| `<A-l>` `<A-h>` | n | Next / previous quickfix item (alternative) |
| `]l` `[l` | n | Next / previous loclist item |
| `]L` `[L` | n | Last / first loclist item |
| `]d` `[d` | n | Next / previous diagnostic (Neovim default) |
| `]t` `[t` | n | Next / previous todo comment (overrides `:tnext`/`:tprevious`) |
| `<A-j>` `<A-k>` | n/v | Move line or selection down / up |
| `<` `>` | v | Indent, keep selection |
| `-` | n | Oil (parent directory) |
| `<C-.>` | n/v | LSP actions menu (same as `<leader>la`, needs terminal support) |
| `gcc` `gc` | n/x | Comment line / motion (Comment.nvim) |
| `gbc` `gb` | n/x | Block comment line / motion |
| `gco` `gcO` `gcA` | n | Comment below / above / end of line |

## Filetype-scoped

| Filetype | Key | Action |
|---|---|---|
| markdown | `j` `k` | Move by screen line (respects wrap); with a count, by real line |

## Related

- [lsp.md](lsp.md) - LSP architecture
- [debugging.md](debugging.md) - DAP setup
- [nvim-lists.md](nvim-lists.md) - quickfix and loclist detail
