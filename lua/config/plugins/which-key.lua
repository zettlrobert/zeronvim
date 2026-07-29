-- https://github.com/folke/which-key.nvim
--
-- Popup after `<leader>` (or any prefix) showing available continuations.
-- Zero cost to muscle memory: only appears if you pause. Every keymap in
-- this config already sets `desc`, so which-key labels are automatic —
-- only the group headers below need explicit spec entries.

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = function(ctx)
      -- Plugin-triggered prompts show instantly; user-driven prefixes wait
      -- 250ms so quick sequences don't flash a popup.
      return ctx.plugin and 0 or 250
    end,
    -- Group labels for the established `<leader>*` namespaces
    spec = {
      { "<leader>q", group = "quickfix" },
      { "<leader>x", group = "examine (trouble)" },
      { "<leader>t", group = "toggle" },
      { "<leader>l", group = "lsp" },
      { "<leader>f", group = "find (telescope)" },
      { "<leader>c", group = "codecompanion" },
      { "<leader>g", group = "git" },
      { "<leader>r", group = "review" },
      { "<leader>b", group = "debug (dap)" },
      { "<leader>T", group = "test (neotest)" },
    },
    icons = {
      -- Rely on nerd font icons where inferred; don't force icon prefix
      -- on every keymap description.
      mappings = false,
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer-local keymaps (which-key)",
    },
  },
}
