-- https://github.com/jiaoshijie/undotree
return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local undotree = require("undotree")

    undotree.setup({
      float_diff = true,
      layout = "left_bottom",
      position = "left",
      ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
      window = {
        winblend = 30,
      },
      -- New format (action = lhs) per :h undotree-configuration.
      -- Multiple keys per action: use a table value, e.g. quit = { "q", "<Esc>" }
      keymaps = {
        move_next = "j",
        move_prev = "k",
        move2parent = "gj",
        move_change_next = "J",
        move_change_prev = "K",
        action_enter = "<cr>",
        enter_diffbuf = "p",
        quit = "q",
      },
    })

    vim.keymap.set("n", "<leader>u", undotree.toggle, { desc = "Undotree: toggle" })
  end,
}
