-- Execute lua code from current file
vim.keymap.set("n", "<leader><leader>x", function()
  vim.api.nvim_command("source %")

  vim.notify("Executed current file via lua", vim.log.levels.INFO)
end, { desc = "Source: execute current file" })

-- Execute lua code from current line
vim.keymap.set("n", "<leader>x", function()
  vim.cmd(":.lua")

  vim.notify("Executed current line via lua", vim.log.levels.INFO)
end, { desc = "Source: execute current line" })

-- Execute visual selection lua code
vim.keymap.set("v", "<leader>x", ":lua<CR>", {
  desc = "Source: execute selection",
  callback = function()
    vim.notify("Executed current selection via lua", vim.log.levels.INFO)
  end,
})
