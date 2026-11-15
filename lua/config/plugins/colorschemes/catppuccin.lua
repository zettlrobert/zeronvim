-- https://github.com/catppuccin/nvim
return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      dim_inactive = {
        enabled = false,
      },
      -- This option ensures, we do not override our set colors
      transparent_background = true,
      term_colors = true,
      -- Diagnostic styling. Top-level `lsp_styles` replaced the old
      -- `integrations.native_lsp`, which catppuccin no longer reads. These
      -- values match catppuccin's defaults; edit here to change them.
      lsp_styles = {
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      integrations = {
        navic = {
          enabled = true,
          custom_bg = "NONE",
        },
        dap = {
          enabled = true,
          enable_ui = true,
        },
      },
    },
    -- The active colorscheme: applied as soon as catppuccin is set up, so
    -- every later plugin sees its highlight groups. The PatchColors autocmd
    -- (lua/config/utils/patch_colorscheme.lua) adjusts it on VimEnter.
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
