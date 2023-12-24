# PDE - Personal Development Experience

This document outlines some thoughts and accumulated knowledge with ambiguous source references.

---

## [PDE: A different take on editing code](https://www.youtube.com/watch?v=QMVIJhC9Veg&t=2s

## :term

`:term` opens a new terminal buffer opens
Type `<C-\>` `<C-N>` to leave Terminal-mode.

## number of occurrences and lines of text

You can serach in a file with the substitution command and append g if we want occurences on one line to count individually, n to print out the number of matches
`%s/<serach>//gn`
`%s/<serach>//n`

## Quickfix List / Location List

Lists need to be populated to be able to display content, the quickfix list is a good locaiton for global searches project wide references

### External Utility

To populate the quickfix list with search results from external utiltiy like `grep` we can use `:cope` followd by the output of the `grep` command

`:cope 'grep pattern **/*.txt'`

### Substitution

nnoremap and vnoremap get converted into the respective vim.keymap(n/v) strings
s/\(.\)noremap(/vim.keymap.set("\1",

## Keymaps

Move up and down in visual mode
"v", "J", ":m '>+1<CR>gv=gv"
"v", "K", ":m '>-2<CR>gv=gv"

Keep Serach Terms in middle when jumping
"n", "n", "nzzzv"
"n", "N", "Nzzzv"
