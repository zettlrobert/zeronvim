--https://github.com/folke/zen-mode.nvim
local kd = require("config.utils.keymap_desc")

return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      { "folke/twilight.nvim", cmd = "Twilight" },
    },
    cmd = "ZenMode",
    keys = {
      -- <leader>t namespace (toggle)
      {
        "<leader>tz",
        function()
          require("zen-mode").toggle({
            plugins = {
              twilight = { enabled = false },
              gitsigns = { enabled = true },
            },
          })
        end,
        desc = kd.format(kd.KIND.TOGGLE, kd.TOOL.ZenMode, "distraction-free mode"),
      },
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
