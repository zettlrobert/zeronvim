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
      { "<leader>a", group = "ai (codecompanion)" },
      { "<leader>b", group = "debug (dap)" },
      { "<leader>c", group = "copy (buffer paths)" },
      { "<leader>e", group = "explorer (nvim-tree)" },
      { "<leader>f", group = "find (telescope)" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>m", group = "markdown" },
      { "<leader>q", group = "quickfix" },
      { "<leader>r", group = "review" },
      { "<leader>R", group = "REST / HTTP (kulala)" },
      { "<leader>s", group = "symbols" },
      { "<leader>t", group = "toggle" },
      { "<leader>td", group = "toggle: debug UIs" },
      { "<leader>T", group = "test (neotest)" },
      { "<leader>x", group = "examine (trouble)" },
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
      desc = "Which-key: buffer-local keymaps",
    },
  },
}
