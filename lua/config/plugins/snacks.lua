-- https://github.com/folke/snacks.nvim
return {
  {
    "https://github.com/folke/snacks.nvim",
    config = function()
      local snacks = require("snacks")
      local kd = require("config.utils.keymap_desc")
      local K, T = kd.KIND, kd.TOOL

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

        -- Auto-disables treesitter, LSP, and other heavyweight features on
        -- files above the size threshold to keep the editor responsive.
        bigfile = { enabled = true },

        -- Highlights other occurrences of the word under the cursor. This
        -- config doesn't wire up LSP's own `textDocument/documentHighlight`,
        -- so snacks.words fills the gap purely textually — works even in
        -- filetypes without an LSP (markdown, plain text, config files).
        words = { enabled = true },

        -- LSP-aware file rename: renaming a filename symbol via LSP also
        -- renames the file on disk. Also lets file explorers (nvim-tree, oil)
        -- fire LSP willRenameFiles so identifier references update project-wide.
        rename = { enabled = true },

        -- Persistent scratch buffers per-cwd. Replaces the pattern of creating
        -- throwaway `todo.md` / `notes.md` files in project roots. Default ft
        -- is markdown; picker at `<leader>S` lets you jump between saved
        -- scratches for the current project.
        scratch = { enabled = true },

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

      -- Show the notifier's toast history. Useful when a notification faded
      -- before you could read it, or to see errors from plugins that route
      -- through vim.notify (e.g. minuet completion failures).
      vim.keymap.set("n", "<leader>nh", function()
        snacks.notifier.show_history()
      end, { desc = kd.format(K.SHOW, T.Notifier, "notification history") })

      -- Scratch buffer keymaps. `<leader>.` opens/toggles the primary scratch
      -- for this cwd (markdown by default). `<leader>S` opens the picker over
      -- all scratches for this cwd — jump between multiple ongoing notes.
      vim.keymap.set("n", "<leader>.", function()
        snacks.scratch()
      end, { desc = kd.format(K.OPEN, T.Scratch, "new scratch buffer") })
      vim.keymap.set("n", "<leader>S", function()
        snacks.scratch.select()
      end, { desc = kd.format(K.PICK, T.Scratch, "select scratch buffer") })
    end,
  },
}
