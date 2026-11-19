--https://github.com/obsidian-nvim/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- track the latest release instead of the latest commit
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

    -- Completion comes from obsidian's built-in obsidian-ls LSP server, which
    -- blink.cmp shows through its lsp source. The old nvim_cmp/blink switches
    -- are deprecated (removed in 4.0) and only trigger a warning.
    completion = {
      min_chars = 2, -- (obsidian default)
    },
  },
}
