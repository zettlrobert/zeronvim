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
      -- Transparent by default; highlight_overrides below gives Normal a
      -- solid mantle background again.
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
      -- Personal tweaks on top of mocha. Applied by catppuccin on every load,
      -- so they survive :colorscheme switches without an extra autocmd.
      highlight_overrides = {
        mocha = function(colors)
          return {
            -- Darker cursor line, rosewater current line number
            CursorLine = { bg = colors.crust },
            CursorLineNr = { fg = colors.rosewater },
            -- Near-invisible window splits. WinSeparator draws them since
            -- Neovim 0.10; VertSplit is kept for plugins still using it.
            WinSeparator = { fg = colors.crust, bg = "NONE" },
            VertSplit = { fg = colors.crust, bg = "NONE" },
            -- Solid background despite transparent_background
            Normal = { bg = colors.mantle },
            -- blink.cmp links its source label to PmenuExtra (overlay0,
            -- grey); match the item label color instead.
            BlinkCmpSource = { fg = colors.overlay2 },
          }
        end,
      },
    },
    -- The active colorscheme: applied as soon as catppuccin is set up, so
    -- every later plugin sees its highlight groups.
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
