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
    },
  },
}
