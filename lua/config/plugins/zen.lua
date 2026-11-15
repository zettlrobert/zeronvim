--https://github.com/folke/zen-mode.nvim
return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      { "folke/twilight.nvim", cmd = "Twilight" },
    },
    cmd = "ZenMode",
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
