local utils = require "zeronvim.utils"
local gitsigns = utils.protected_plugin_call("gitsigns")

--local BoldLineLeft = '▎'
--local Triangle = '󰐊'
--local Untracked = 'U'
--local Dashed = '┆'

local signs = {
  add          = '│',
  change       = '│',
  delete       = '_',
  topdelete    = '‾',
  changedelete = '~',
  untracked    = '┆',
}

if gitsigns then
  gitsigns.setup(
    require('gitsigns').setup {
      signs                        = {
        add = {
          hl = "GitSignsAdd",
          text = signs.add,
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn"
        },
        change = {
          hl = "GitSignsChange",
          text = signs.change,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn"
        },
        delete = {
          hl = "GitSignsDelete",
          text = signs.delete,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn"
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = signs.topdelete,
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn"
        },
        changedelete = {
          hl = "GitSignsChange",
          text = signs.changedelete,
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn"
        },
        untracked = {
          hl = 'GitSignsAdd',
          text = signs.untracked,
          numhl = 'GitSignsAddNr',
          linehl = 'GitSignsAddLn'
        },
      },
      signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir                 = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked          = true,
      current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil,   -- Use default
      max_file_length              = 40000, -- Disable if file is longer than this (in lines)
      preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm                         = {
        enable = false
      },
    }
  )
end
