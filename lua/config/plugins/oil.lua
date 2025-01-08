return {
  {
    "stevearc/oil.nvim",
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

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil open parent directory" })
      vim.keymap.set("n", "<space>-", oil.toggle_float, { desc = "Oil open parent directory in floating window" })
    end
  }
}
