# LSP (2025)

[Advent of Neovim TJ](https://www.youtube.com/watch?v=bTWWFQZqzyI)

## TODO

### Core

#### LSP Completion

- [x] navic + navbuddy + breadcrumbs
- [x] formatting
  - [x] with prettier
  - [x] fmt keymap
  - [x] none-ls.lua

#### DAP

- [ ] dap-go.lua
- [ ] dap-vscode-js.lua
- [ ] dap.lua

#### UI

- [ ] snacks
  - [x] animate
  - [x] indent
  - [x] scroll
  - [x] statuscolumn
- [x] fidget.lua
- [x] bufferline - used lua line
- [x] NvimTree

#### AI

- [x] codium setup (blink completion)
- [ ] local AI for completions
- [ ] gen.lua

#### Utils

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
- [ ] trunk.lua
- [ ] vale

  ### Refactors

  - [ ] update all keymaps to use vim.api.nvim_command instead of manual `":Command <CR>"`

  ***

## Learn

- [ ] read :h ins-completion

---

## Features

- [ ] Popup Modal with all the shortcuts i could want!
  - LSP - gra, ctrl+]...
  - Oil
  - telescope file browser
  - gitsigns
- [ ] Scratchpad file with picker (telescope open nvim config example)

## Note

CTRL+XL - Complete Line after pattern

## Bugs

- [ ] border for vim.lsp.buf.hover

---

## Debugging

For me it was treesitter and an indent plugin, but lookup how to profile.
It's quite easy to set up two profile keybindings (one to start, one to stop and open the log).
Then you just start, write a bit, stop, look at log.
You'll see at the very bottom a summary and entries that look like <SNR>[number] and how long they took.
Then use :scriptnames to see what script/plugin the number belongs to.

```lua
wk.register({ p = { name = "Perf Profiling" } }, { prefix = "<leader>u" })

vim.keymap.set("n", "<leader>ups", function()
	vim.cmd([[
		:profile start /tmp/nvim-profile.log
		:profile func *
		:profile file *
	]])
end, { desc = "Profile Start" })

vim.keymap.set("n", "<leader>upe", function()
	vim.cmd([[
		:profile stop
		:e /tmp/nvim-profile.log
	]])
end, { desc = "Profile End" })
```
