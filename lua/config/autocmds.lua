-- Editor-wide autocmds that belong to no plugin. Plugin-specific autocmds live
-- in their plugin spec, LSP ones in lua/config/lsp/init.lua.

-- Presentation markdown (*.presentation.md, see utils/is_presentation_markdown)
-- shows concealed text more literally than regular notes.
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("config.presentation_markdown", { clear = true }),
  pattern = "*.presentation.md",
  callback = function()
    vim.notify(
      "Setting conceallevel to 1 for presentation markdown",
      vim.log.levels.INFO,
      { title = "Conceallevel Set" }
    )

    -- opt_local scopes to the current buffer/window — using `vim.opt` here
    -- leaked the setting globally and left conceallevel = 1 in every buffer
    -- opened afterwards until nvim restarted.
    vim.opt_local.conceallevel = 1
  end,
})

-- Briefly highlight yanked text so you can see what got copied. Uses the
-- `IncSearch` highlight group by default and fades after ~150ms.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
