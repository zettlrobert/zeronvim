-- https://github.com/folke/snacks.nvim
return {
  {
    "https://github.com/folke/snacks.nvim",
    enabled = true,
    config = function()
      local snacks = require("snacks")

      snacks.setup({
        animate = {
          enabled = true,
          easing = 'linear'
        },

        indent = {
          enabled = true,
          hl = 'SnacksIndent',
          animate = {
            enabled = false,
          },
          scope = {
            hl = "ModeMsg"
          }
        },

        scroll = {
          enabled = true,
          easing = 'linear'
        },

        statuscolumn = {
          enabled = true,
          left = { "mark", "sign" }, -- priority of signs on the left (high to low)
          right = { "fold", "git" }, -- priority of signs on the right (high to low)
          folds = {
            open = true,             -- show open fold icons
            git_hl = true,           -- use Git Signs hl for fold icons
          },
          git = {
            -- patterns to match Git signs
            patterns = { "GitSign" },
          },
        }
      })
    end
  }
}
