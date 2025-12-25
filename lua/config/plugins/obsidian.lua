--https://github.com/obsidian-nvim/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
  version = "v3.14.2", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  opts = {
    workspaces = {
      {
        name = "zettl",
        path = "~/notes/zettl",
      },
      {
        name = "luminaria",
        path = "~/repositories/github.com/luminaria-life/luminaria-wiki/",
      },
      {
        name = "zerodev-solutions",
        path = "~/notes/zerodev-solutions",
      },
      {
        name = "mobilehead",
        path = "~/notes/mobilehead",
      },
    },

    legacy_commands = false,

    ui = {
      enable = false,
    },

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
  },
}
