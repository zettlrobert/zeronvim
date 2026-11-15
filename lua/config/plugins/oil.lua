-- https://github.com/stevearc/oil.nvim
local kd = require("config.utils.keymap_desc")
local K, T = kd.KIND, kd.TOOL

return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      {
        "echasnovski/mini.icons", opts = {}
      }
    },
    -- Safe to lazy-load: default_file_explorer = false, so oil never has to
    -- take over directory buffers at startup.
    cmd = "Oil",
    keys = {
      { "-", "<CMD>Oil<CR>", desc = kd.format(K.OPEN, T.Oil, "parent directory") },
      {
        "<leader>-",
        function()
          require("oil").toggle_float()
        end,
        desc = kd.format(K.OPEN, T.Oil, "parent directory (float)"),
      },
    },
    opts = {
      default_file_explorer = false,
      columsn = {
        "icon"
      },
      view_options = {
        show_hidden = true
      }
    },
  }
}
