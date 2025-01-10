-- https://github.com/catppuccin/nvim - Soothing pastel theme for Neovim

-- Manual adjustments to the color scheme
local crust = "#11111B"
local mantle = "#181825"
local rosewater = "#F5e0DC"
local none = "none"

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local catppuccin = require("catppuccin")

      catppuccin.setup({
        flavour = "mocha",
        dim_inactive = {
          enabled = false,
        },
        -- This option ensures, we do not override our set colors
        transparent_background = true,
        term_colors = true,
        integrations = {
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
          dap = {
            enabled = true,
            enable_ui = true,
          },
          native_lsp = {
            enabled = true,
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
        },
      })
      --
      -- Set colorscheme
      vim.cmd.colorscheme("catppuccin")
      --
      -- Cursorline Configuration
      vim.api.nvim_set_hl(0, "CursorLine", { bg = crust })
      --
      -- Line Number of current Line - if cursorline is not active use LineNr
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = rosewater })
      --
      -- Custom Color for Window Split Seperator
      vim.api.nvim_set_hl(0, "VertSplit", { fg = crust, bg = none })
      --
      -- Set Background Color
      vim.api.nvim_set_hl(0, "Normal", { bg = mantle })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
  },
}
