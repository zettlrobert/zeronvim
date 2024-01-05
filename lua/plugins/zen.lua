-- https://github.com/folke/zen-mode.nvim - Distraction-free coding for Neovim

-- Set keymap for ZenMode
vim.keymap.set("n", "<leader>zen", ":ZenMode<CR>", { desc = "Toggle ZenMode" })

return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = false },
        gitsigns = { enabled = false },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
      end,
    },
  },
}
