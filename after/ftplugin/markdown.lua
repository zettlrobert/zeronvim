-- Markdown-specific options. Reading a lot of prose, so we soft-wrap visually
-- without committing line breaks to the file. j/k follow the wrapped lines.

vim.opt_local.conceallevel = 2

-- Soft wrap at the window edge, break at word boundaries, preserve indent
-- on wrapped lines, mark continuation lines with a subtle prefix.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.showbreak = "↳ "

-- Vertical movement respects wrapped lines (j/k skip wrapped segments otherwise).
-- gj/gk are the screen-line variants of j/k. expr = true so counts work.
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { buffer = 0, expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { buffer = 0, expr = true, silent = true })
