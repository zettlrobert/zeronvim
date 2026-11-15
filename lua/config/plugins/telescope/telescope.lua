-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
return {
  "nvim-telescope/telescope.nvim",
  -- Loaded on demand: the <leader>f keymaps in config/keymaps.lua require
  -- telescope.builtin, which lazy.nvim turns into a load.
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local telescope_actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          -- <C-q> keeps its default (smart_send_to_qflist = REPLACE qf).
          -- <C-a> appends to the existing qf without wiping prior results,
          -- letting you accumulate matches across multiple searches.
          i = {
            ["<C-a>"] = telescope_actions.smart_add_to_qflist + telescope_actions.open_qflist,
          },
          n = {
            ["<C-a>"] = telescope_actions.smart_add_to_qflist + telescope_actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files" },
          theme = "ivy",
        },
        help_tags = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
        },
        live_grep = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {},
      },
    })

    -- Load telescope extensions
    telescope.load_extension("fzf")
  end,
}
