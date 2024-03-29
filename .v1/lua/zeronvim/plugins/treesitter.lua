local utils = require "zeronvim.utils"
local treesitter_configs = utils.protected_plugin_call("nvim-treesitter.configs")
local ts_context_commentstring = utils.protected_plugin_call("treesitter-context")

if treesitter_configs then
  treesitter_configs.setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    autopairs = {
      enable = true
    },

    autotag = {
      enable = true
    },

    highlight = {
      enable = true,
      -- list of language that will be disabled
      disable = { "" },
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },

    ts_context_commentstring = {
      enable          = true,
      enablue_autocmd = false
    },

    -- TODO: Advanced Textobject Configuration
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        -- TODO:
        -- https://www.youtube.com/watch?v=FuYQ7M73bC0
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = "@parameter.outer",
          ['ia'] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          --[[ ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" }, ]]
          -- You can also use captures from other query groups like `locals.scm`
          --[[ ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" }, ]]
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = true,
      },
    },
  }
end

if ts_context_commentstring then
  ts_context_commentstring.setup {
    enable = true,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
  }
end
