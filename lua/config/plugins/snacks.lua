-- https://github.com/folke/snacks.nvim
return {
  {
    "https://github.com/folke/snacks.nvim",
    config = function()
      local snacks = require("snacks")

      snacks.setup({
        animate = {
          enabled = true,
          easing = "linear",
        },

        indent = {
          enabled = true,
          hl = "SnacksIndent",
          animate = {
            enabled = false,
          },
          scope = {
            hl = "ModeMsg",
          },
        },

        scroll = {
          enabled = true,
          easing = "linear",
        },

        statuscolumn = {
          enabled = true,
          left = { "mark", "sign" }, -- priority of signs on the left (high to low)
          right = { "fold", "git" }, -- priority of signs on the right (high to low)
          folds = {
            open = true,             -- show open fold icons
            git_hl = true,           -- use Git Signs hl for fold icons
          },
          git = {
            -- patterns to match Git signs
            patterns = { "GitSign" },
          },
        },

        -- Replaces vim.ui.input (LSP rename prompt, other single-line prompts).
        -- Matches the ivy-styled picker for a consistent feel.
        input = { enabled = true },

        -- Replaces vim.notify with toast notifications plus history.
        -- View past notifications: `:Snacks notifier show_history`.
        notifier = {
          enabled = true,
          timeout = 3000,
        },

        -- Closes buffers without collapsing the window layout.
        -- Callable as `Snacks.bufdelete()` or via `:lua Snacks.bufdelete()`.
        bufdelete = { enabled = true },

        picker = {
          enabled = true,
          ui_select = true, -- register as vim.ui.select handler
          sources = {
            -- Ivy = bottom-anchored, matches the telescope-ivy theme used in
            -- telescope pickers. Scoped to `select` so only vim.ui.select is
            -- affected; other snacks.picker uses (if added later) keep defaults.
            select = {
              -- No preview: menu items (LSP actions, server toggles, etc.) have
              -- nothing meaningful to preview and the pane just eats space.
              layout = { preset = "ivy", preview = false },
            },
          },
        },
      })
    end,
  },
}
