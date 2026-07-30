return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      {
        "echasnovski/mini.icons", opts = {}
      }
    },
    config = function()
      local oil = require("oil")

      oil.setup({
        default_file_explorer = false,
        columsn = {
          "icon"
        },
        view_options = {
          show_hidden = true
        }
      })

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil: parent directory" })
      vim.keymap.set("n", "<leader>-", oil.toggle_float, { desc = "Oil: parent directory (float)" })
    end
  }
}
