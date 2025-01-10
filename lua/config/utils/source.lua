-- Execute lua code from current file
vim.keymap.set("n", "<space><space>x", function()
  vim.api.nvim_command("source %")

  vim.notify("Executed current file via lua", vim.log.levels.INFO)
end, { desc = "source: execute current file via lua" })

-- Execute lua code from current line
vim.keymap.set("n", "<space>x", function()
  vim.cmd(":.lua")

  vim.notify("Executed current line via lua", vim.log.levels.INFO)
end, { desc = "source: execute current nvim config line via lua" })

-- Execute visual selection lua code
vim.keymap.set("v", "<space>x", ":lua<CR>", {
  desc = "source: execute current nvim selection via lua",
  callback = function()
    vim.notify("Executed current selection via lua", vim.log.levels.INFO)
  end,
})
