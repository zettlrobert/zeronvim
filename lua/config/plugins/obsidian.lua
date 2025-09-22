--https://github.com/obsidian-nvim/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  opts = {
    legacy_commands = false,
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
    ui = {
      enable = true,
    },
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      blink = true,
      min_chars = 2,
    },
    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    -- mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    -- ["gf"] = {
    --   action = function()
    --     return require("obsidian").util.gf_passthrough()
    --   end,
    --   opts = { noremap = false, expr = true, buffer = true },
    -- },
    -- Toggle check-boxes.
    -- ["<leader>ch"] = {
    --   action = function()
    --     return require("obsidian").util.toggle_checkbox()
    --   end,
    --   opts = { buffer = true },
    -- },
    -- Smart action depending on context, either follow link or toggle checkbox.
    -- ["<cr>"] = {
    --   action = function()
    --     return require("obsidian").util.smart_action()
    --   end,
    --   opts = { buffer = true, expr = true },
    -- },
    -- },
  },
}
