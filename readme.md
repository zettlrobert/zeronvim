# LSP (2025)

https://www.youtube.com/watch?v=bTWWFQZqzyI


## TODO

- [x] sort and move utils from v2
- [x] codium setup (blink completion)
    - [x] get_system_binary utils
    - [x] setup codeium.lua
    - [x] setup [blink.compat](https://github.com/saghen/blink.compat) for codeium completion
- [x] navic + navbuddy + breadcrumbs
- [x] lazyvim smooth scrolling - neoscroll 
- [x] NvimTree
- [x] Tescope file browser adjust keymaps (used for NvimTree)
- [x] setup spellchecking and custom toggles
- [x] formatting 
    - [x] with prettier 
    - [x] fmt keymap
    - [x] none-ls.lua
- [ ] trouble.lua, telescope quickfix list shortcuts
- [ ] blame.lua
- [ ] colorpicker.lua
- [x] completions.lua - blink.cmp
    - [ ] locall ai for completions
- [x] colorschemes.lua
- [x] comment.lua
- [ ] dap-go.lua
- [ ] dap-vscode-js.lua
- [ ] dap.lua
- [x] fidget.lua
- [ ] gen.lua
- [x] gitsigns.lua
- [x] indent-blankline.lua --> replaced snacks indent
- [x] lazydev.lua
- [x] lsp-config.lua
- [x] lsp-saga.lua
- [x] lsp.lua
- [x] lualine.lua
  - [ ] add the icons used in the configuratio to my assets/icons file
- [ ] mini-icons.lua
- [ ] obsidian.lua
- [ ] neorg.lua
- [ ] render-markdown.lua
- [x] nvim-tree.lua
- [x] oil.lua
- [ ] telescope.lua
- [ ] todo-comments.lua
- [x] treesitter.lua
- [ ] trunk.lua
- [x] undotree.lua
- [ ] zen
- [ ] vale
- [ ] snacks
  - [x] animate
  - [x] indent
  - [x] scroll
  - [x] statuscolumn

## Learn

- [ ] read :h ins-completion

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
