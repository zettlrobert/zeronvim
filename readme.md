# Zeronvim

Personal Neovim config: lazy.nvim, native LSP (`vim.lsp.enable`), blink.cmp, conform.nvim and nvim-lint.

Good place to get started with Neovim: [The Only Video You Need to Get Started with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o&t=1275s)

## Docs

| Doc | Covers |
|---|---|
| [keymaps.md](docs/keymaps.md) | Every keymap, by `<leader>` namespace |
| [lsp.md](docs/lsp.md) | `after/lsp/` server configs, Mason install, server toggles |
| [completion.md](docs/completion.md) | blink.cmp sources |
| [formatting.md](docs/formatting.md) | conform.nvim, format on save, `<leader>lf` |
| [linting.md](docs/linting.md) | LSP linters, nvim-lint, git hook parity |
| [vale.md](docs/vale.md) | On-demand prose linting with vale-ls |
| [ai.md](docs/ai.md) | Copilot, Minuet, CodeCompanion |
| [debugging.md](docs/debugging.md) | nvim-dap, adapters, neotest |
| [nvim-lists.md](docs/nvim-lists.md) | Quickfix and location lists |

## Requirements

- Neovim 0.12+ (`vim.lsp.enable(name, false)`, `vim.diagnostic.jump` defaults)
- tree-sitter CLI
- `rg` (telescope `find_files` and live grep)
- `make` (telescope-fzf-native build)
- `node` v20+ for Copilot; Ollama for Minuet (see [ai.md](docs/ai.md))

## Known Bugs

- [x] border for vim.lsp.buf.hover: `winborder = "rounded"` in `lua/config/options.lua`; the diagnostic float sets its own in `lua/config/lsp/init.lua`

---

## Plugin Docs

- [Blink Completion - blink.cmp](https://cmp.saghen.dev/)
- [NvimTree - File Explorer](https://docs.rockylinux.org/books/nvchad/nvchad_ui/nvimtree/)
- [lazy.nvim](https://lazy.folke.io/)
- [presenterm](https://github.com/mfontanini/presenterm) for presentations (`*.presentation.md` skips format on save)

---

## TODO

- [x] switch markdown renderer (<https://github.com/OXY2DEV/markview.nvim>)
  - compare with render-markdown
- [x] diffview - setup
- [x] close quickfix list when opened in trouble (quickfixlist filetype is `qf`)
- [x] lualine icons into icons file
- [x] session: persistence.nvim (`<leader>P*`)
- [x] Dashboard: snacks.dashboard (shows on bare `nvim` launch)
- [x] keymaps descriptions
- [x] dap-go.lua
- [x] dap-vscode-js.lua
- [x] dap.lua
- [x] vale
- [x] none-ls.nvim: replaced by conform.nvim (formatters) + nvim-lint (linters)
- [-] toggleterm: skipped, a terminal multiplexer covers it

### DIY Features

- [ ] [Neovim confv 2024](https://www.youtube.com/watch?v=TUzdcB_PFJA&list=PLhlaLyAlbLlq9xWf2xm_9p422GgqvATXk&index=1)
- [x] Popup modal with all the shortcuts: which-key.nvim
- [x] Scratchpad file with picker: snacks.scratch (`<leader>.` new, `<leader>S` pick)
- [x] Add items to the quickfix list via telescope without overwriting it: `<C-a>` in any telescope picker
- [x] Spellcheck toggle: `<leader>ts`, plus `:Spellcheck`

### Refactors

- [x] LSP integration cleanup: consolidate three overlapping mechanisms into the native Neovim setup
  - mason for binary installation only; `after/lsp/` for all configs; its filenames drive `vim.lsp.enable()`
- [ ] update all keymaps to use vim.api.nvim_command instead of manual `":Command <CR>"`

### Setup

- [Awesome Neovim - Plugin Overview](https://github.com/rockerBOO/awesome-neovim/blob/main/README.md#tabline)

- [x] navic + navbuddy; breadcrumbs.nvim replaced by a lualine winbar with navic
- [x] formatting
  - [x] with prettier
  - [x] fmt keymap
  - [x] via conform.nvim (none-ls replacement)
- [-] snacks
  - [x] animate
  - [x] indent
  - [x] scroll
  - [x] statuscolumn
  - [x] picker (ui_select handler)
  - [x] input
  - [x] notifier
  - [x] bufdelete
  - [x] bigfile
  - [x] words
  - [x] rename
  - [x] scratch
  - [x] dashboard
- [x] fidget.lua
- [x] bufferline - used lua line
- [x] NvimTree
- [x] codium setup (blink completion), later removed
- [x] local AI for completions: [minuet-ai.nvim](https://github.com/milanglacier/minuet-ai.nvim) + Ollama `qwen2.5-coder:7b-base` FIM; see `docs/ai.md`
- [x] sort and move utils from v2
  - [x] get_system_binary utils
  - [x] setup codeium.lua (removed since)
  - [x] setup [blink.compat](https://github.com/saghen/blink.compat) for codeium completion (removed with codeium)
- [x] Telescope file browser adjust keymaps (used for NvimTree)
- [x] setup spellchecking and custom toggles
- [x] colorpicker.lua
- [x] trouble.lua, telescope quickfix list shortcuts
- [x] todo-comments.lua
- [-] obsidian.lua
- [x] open in new tab and close current buffer - use telescope
- [x] diagnostics add custom icons
- [x] render-markdown.lua
- [x] blame.lua
- [x] completions.lua - blink.cmp
- [x] colorschemes (`lua/config/plugins/colorschemes/`, one file per theme)
- [x] comment.lua
- [x] gitsigns.lua
- [x] indent-blankline.lua: replaced by snacks indent
- [x] lazydev.lua
- [x] lspconfig.lua
- [x] lsp-saga.lua (removed since)
- [x] lsp.lua
- [x] lualine.lua
- [x] add the icons used in the configuration to `lua/config/assets/icons.lua`
- [x] mini-icons.lua
- [x] nvim-tree.lua
- [x] oil.lua
- [x] telescope.lua
- [x] treesitter.lua
- [x] undotree.lua
- [x] zen
- [x] conceallevel for json files: disabled (`after/ftplugin/json.lua`)
