# Zeronvim

Good place to get started with neovim: [The Only Video You Need to Get STarted with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o&t=1275s)

## Requirements

- tree-sitter

## Known Bugs

- [ ] border for vim.lsp.buf.hover

---

## Plugin Docs

- [Blink Completion - blink.cmp](https://cmp.saghen.dev/)
- [NvimTree - File Explorer](https://docs.rockylinux.org/books/nvchad/nvchad_ui/nvimtree/)
- [lazy.nvim](https://lazy.folke.io/)
- Presentterm for Presentations

---

## TODO

- [x] switch markdown renderer (https://github.com/OXY2DEV/markview.nvim)
  - compare with render-markdown
- [x] diffview - setup
- [x] close quickfix list when opened in trouble (quickfixlist filetype is `qf`)
- [x] lualine icons into icons file
- [ ] session
- [ ] Dashboard
  - [mini-starter](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md)
  - [alpha-nvim](https://github.com/goolord/alpha-nvim)
  - [snacks.nvim dashboard](https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md)
- [x] keymaps descriptions
- [x] dap-go.lua
- [x] dap-vscode-js.lua
- [x] dap.lua
- [x] vale
- [x] none-ls.nvim → replaced by conform.nvim (formatters) + nvim-lint (linters)
- [ ] toggleterm

### DIY Features

- [ ] [Neovim confv 2024](https://www.youtube.com/watch?v=TUzdcB_PFJA&list=PLhlaLyAlbLlq9xWf2xm_9p422GgqvATXk&index=1)
- [x] Popup Modal with all the shortcuts i could want! → which-key.nvim
- [ ] Scratchpad file with picker (telescope open nvim config example)
- [ ] Add item to quickfix list via telescope without overwriting it
- [x] Spellcheck, keybind for enable and disabling (value included)

### Refactors

- [x] LSP integration cleanup — consolidate three overlapping mechanisms into native Neovim 0.11+ setup
  - mason for binary installation only; `lsp/` dir for all configs; `vim.lsp.enable()` as single source of truth
- [ ] update all keymaps to use vim.api.nvim_command instead of manual `":Command <CR>"`

### Setup

- [Awesome Neovim - Plugin Overview](https://github.com/rockerBOO/awesome-neovim/blob/main/README.md#tabline)

- [x] navic + navbuddy + breadcrumbs
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
- [x] fidget.lua
- [x] bufferline - used lua line
- [x] NvimTree
- [x] codium setup (blink completion)
- [ ] local AI for completions
  - [cmp-ai](https://github.com/tzachar/cmp-ai)
- [x] sort and move utils from v2
  - [x] get_system_binary utils
  - [x] setup codeium.lua
  - [x] setup [blink.compat](https://github.com/saghen/blink.compat) for codeium completion
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
- [x] colorschemes.lua
- [x] comment.lua
- [x] gitsigns.lua
- [x] indent-blankline.lua --> replaced snacks indent
- [x] lazydev.lua
- [x] lsp-config.lua
- [x] lsp-saga.lua
- [x] lsp.lua
- [x] lualine.lua
- [x] add the icons used in the configuratio to my assets/icons file
- [x] mini-icons.lua
- [x] nvim-tree.lua
- [x] oil.lua
- [x] telescope.lua
- [x] treesitter.lua
- [x] undotree.lua
- [x] zen
- [x] conceallevel for json files --> disabled
