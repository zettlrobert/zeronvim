return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim'
  },
  config = function()
    local keymap = vim.keymap.set
    local telescope_builtin = require('telescope.builtin')
    local telescope = require('telescope')
    local telescope_themes = require('telescope.themes')
    local trouble = require("trouble.providers.telescope")

    telescope.setup({
      pickers = {
        find_files = {
          find_command = { 'rg', '--hidden', '--files' },
        }
      },
      extensions = {
        ["ui-select"] = {
          telescope_themes.get_dropdown {}
        }
      },
      defaults = {
        mappings = {
          i = { ["<c-y>"] = trouble.open_with_trouble },
          n = { ["<c-y>"] = trouble.open_with_trouble },
        }
      }
    })

    telescope.load_extension('ui-select')

    local find_env_file = function()
      if telescope_builtin.builtin then
        telescope_builtin.find_files({ no_ignore = true })
      end
    end

    keymap('n', '<leader>ff', telescope_builtin.find_files, { desc = "Telescope find files" })
    keymap('n', '<leader>fg', telescope_builtin.live_grep, { desc = "Telescope live grep" })
    keymap('n', '<leader>fb', telescope_builtin.buffers, { desc = "Telescope opened buffers" })
    keymap('n', '<leader>fh', telescope_builtin.help_tags, { desc = "Telescope help tags" })
    keymap('n', '<leader>key', telescope_builtin.keymaps, { desc = "Telescope keymaps" })
    keymap('n', '<leader>fy', find_env_file, { desc = "Telescope find ignored files" })
  end
}
