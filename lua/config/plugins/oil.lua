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
      local kd = require("config.utils.keymap_desc")
      local K, T = kd.KIND, kd.TOOL

      oil.setup({
        default_file_explorer = false,
        columsn = {
          "icon"
        },
        view_options = {
          show_hidden = true
        }
      })

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = kd.format(K.OPEN, T.Oil, "parent directory") })
      vim.keymap.set("n", "<leader>-", oil.toggle_float, { desc = kd.format(K.OPEN, T.Oil, "parent directory (float)") })
    end
  }
}
