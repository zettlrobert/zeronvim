---https://github.com/zbirenbaum/copilot.lua
return {
  "zbirenbaum/copilot.lua",
  -- Pinned: newer HEAD regressed to `vim.lsp.stop_client` (deprecated in 0.12)
  -- and prints a deprecation toast on every startup that disables copilot.
  -- v3.0.1 uses the modern `client:stop()` method — no deprecation noise.
  version = "v3.0.1",
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
  },
  config = function()
    local copilot = require("copilot")
    local kd = require("config.utils.keymap_desc")
    local K, T = kd.KIND, kd.TOOL

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
        -- doesn't fire every startup when our startup_disable_all runs.
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
        type = "nodejs", -- "nodejs" | "binary"
        custom_server_filepath = nil,
      },
      server_opts_overrides = {},
    })

    vim.keymap.set("n", "<leader>ap", function()
      require("config.utils.ai_toggle").toggle_copilot()
    end, { desc = kd.format(K.TOGGLE, T.Copilot, "AI suggestions") })

    -- Default off. Enable on demand via <leader>ap or <leader>aA.
    -- Deferred so copilot.setup has finished initializing before disable runs.
    vim.schedule(function()
      require("config.utils.ai_toggle").disable_copilot({ silent = true })
    end)
  end,
}
