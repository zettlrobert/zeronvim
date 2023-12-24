-- Fix color issues
local crust = "#11111B"
local mantle = "#181825"
local rosewater = "#F5e0DC"
local none = 'none'

return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        dim_inactive = {
          enabled = false,
        },
        transparent_background = false,
        term_colors = true,
        dap = {
          enabled = false,
          enable_ui = false,
        },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
      })

      -- Set colorscheme
      vim.cmd.colorscheme "catppuccin"

      --Cursorline Configuration
      vim.api.nvim_set_hl(0, "CursorLine", { bg = crust })

      -- Line Number of current Line - if cursorline is not active use LineNr
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = rosewater })

      -- Custom Color for Window Split Seperator
      vim.api.nvim_set_hl(0, "VertSplit", { fg = crust, bg = none })

      -- Set Background Color
      vim.api.nvim_set_hl(0, 'Normal', { bg = mantle })
    end
  }
}
