---https://github.com/zbirenbaum/copilot.lua
return {
  "zbirenbaum/copilot.lua",
  -- v3.2+ no longer bundles the server in the repo: it downloads the native
  -- copilot-language-server into stdpath("data")/copilot.lua/lsp on first use.
  -- Older tags (v3.0.1) lost copilot/js/ upstream and fail with
  -- "could not find server (bad install?)".
  version = "^3.2",
  -- Loaded only when enabled through config.utils.ai_toggle (<leader>ap or
  -- <leader>aA in config/keymaps.lua), never at startup.
  lazy = true,
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },
  config = function()
    local copilot = require("copilot")

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })

    copilot.setup({
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom", -- | top | left | right | horizontal | vertical
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        debounce = 75,
        trigger_on_accept = true,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
      logger = {
        file = vim.fn.stdpath("log") .. "/copilot-lua.log",
        file_log_level = vim.log.levels.OFF,
        -- ERROR (not WARN) so copilot's own "copilot is disabled" WARN toast
        -- doesn't fire when the default-off disable below runs.
        print_log_level = vim.log.levels.ERROR,
        trace_lsp = "off", -- "off" | "messages" | "verbose"
        trace_lsp_progress = false,
        log_lsp_messages = false,
      },
      copilot_node_command = "node", -- Node.js version must be > 20
      workspace_folders = {},
      copilot_model = "",
      root_dir = function()
        return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
      end,
      should_attach = function(_, _)
        if not vim.bo.buflisted then
          return false
        end

        if vim.bo.buftype ~= "" then
          return false
        end

        return true
      end,
      server = {
        type = "binary", -- "binary" (native, downloaded) | "nodejs" (needs custom_server_filepath)
        custom_server_filepath = nil,
      },
      server_opts_overrides = {},
    })

    -- Default off on every load path (ai_toggle, :checkhealth, a require).
    -- ai_toggle queues its enable after this, so an explicit enable wins.
    -- Deferred so copilot.setup has finished initializing before disable runs.
    vim.schedule(function()
      require("config.utils.ai_toggle").disable_copilot({ silent = true })
    end)
  end,
}
