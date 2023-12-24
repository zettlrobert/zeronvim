# Zerovim and Lua

Lua is one of nvims killer features, this document will summarize ressources and bits of useful information regarding the process of learning the language.

## Ressources

- [nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide) - nanotees awesome guide on lua in nvim

### Getting started With Lua

In a lua based nvim configuration `init.lua` in the root directory replaces the old `init.vim`.
Lua modules will be kept in a `lua/` folder located in our `runtimepath`.
Files in this folder can be `required()` as Lua modules, the file extension `.lua` is excluded.

#### Runtime files

Like `vimscript` files, Lua files can be loaded automatically from special folders in the runtimepath. Currently, the following is supported

| runtimepath folder | description                  | filetype                  |
| ------------------ | ---------------------------- | ------------------------- |
| filetype.vim       | filetypes by file name       | new-filetype              |
| scripts.vim        | filetypes by file contents   | new-filetype-scripts      |
| autoload/          | automatically loaded scripts | autoload-functions        |
| colors/            | color scheme files           | :colorscheme              |
| compiler/          | compiler files               | :compiler                 |
| doc/               | documentation                | write-local-help          |
| ftplugin/          | filetype plugins             | write-filetype-plugin     |
| indent/            | indent scripts               | indent-expression         |
| keymap/            | key mapping files            | mbyte-keymap              |
| lang/              | menu translations            | :menutrans                |
| menu.vim           | GUI menus                    | menu.vim                  |
| pack/              | packages                     | :packadd                  |
| plugin/            | plugin scripts               | write-plugin              |
| print/             | files for printing           | postscript-print-encoding |
| rplugin/           | remote-plugin                | scripts                   |
| spell/             | spell checking files         | spell                     |
| syntax/            | syntax files                 | mysyntaxfile              |
| tutor/             | tutorial files               | :Tutor                    |
