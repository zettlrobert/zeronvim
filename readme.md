# Zeronvim

## Requirements

- tree-sitter

## Known Bugs

- [ ] border for vim.lsp.buf.hover

---

## TODO

### DIY Features

- [ ] Popup Modal with all the shortcuts i could want!
  - LSP - gra, ctrl+]...
  - Oil
  - telescope file browser
  - gitsigns
- [ ] Scratchpad file with picker (telescope open nvim config example)

### Refactors

- [ ] update all keymaps to use vim.api.nvim_command instead of manual `":Command <CR>"`

### Setup

- [x] navic + navbuddy + breadcrumbs
- [x] formatting
  - [x] with prettier
  - [x] fmt keymap
  - [x] none-ls.lua
- [ ] dap-go.lua
- [ ] dap-vscode-js.lua
- [ ] dap.lua
- [-] snacks
  - [x] animate
  - [x] indent
  - [x] scroll
  - [x] statuscolumn
- [x] fidget.lua
- [x] bufferline - used lua line
- [x] NvimTree
- [x] codium setup (blink completion)
- [ ] local AI for completions
- [ ] gen.lua
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
- [ ] lualine icons into icons file
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
- [ ] trunk.lua
- [ ] vale
- [~] none-ls.nvim
  - [ ] [cspell](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#cspell)
  - [ ] [codespell](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#codespell)
  - [ ] [proselint](https://valentjn.github.io/ltex/)
  - [ ] [ltex](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#codespell)
  - [ ] [spell](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#spell)
  - [ ] [writegood](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#write_good)
- [ ] toggleterm
- [ ] diffview
- [ ] dashboard (mini or snacks)
- [ ] session
- [ ] keymaps descriptions
