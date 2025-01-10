--https://github.com/folke/zen-mode.nvim
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
    config = function()
      local zen_mode = require("zen-mode")

      -- Set keymap for ZenMode
      vim.keymap.set("n", "<leader>zen", function()
        zen_mode.toggle({
          plugins = {
            twilight = { enabled = false },
            gitsigns = { enabled = true },
          },
        })
      end, { desc = "Toggle ZenMode" })
    end,
  },
}
