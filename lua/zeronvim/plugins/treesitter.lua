local utils = require "zeronvim.utils"
local treesitter_configs = utils.protected_plugin_call("nvim-treesitter.configs")
local treesitter_context = utils.protected_plugin_call("treesitter-context")

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

    context_commentstring = {
      enable          = true,
      enablue_autocmd = false
    }
  }
end

if treesitter_context then
  treesitter_context.setup {
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
