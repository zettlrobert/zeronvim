local colorscheme = "catppuccin"

local status_ok, catppuccin = pcall(require, colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- catppuccin configuration
catppuccin.setup({
  flavour = "mocha",
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentagp = 0.65,
  },
  transparent_background = true,
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath "cache" .. "/catppuccin",
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    treesitter = true,
    treesitter_context = true,
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
    coc_nvim = false,
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    leap = false,
    telescope = true,
    nvimtree = true,
    neotree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = true,
    symbols_outline = true,
    mini = false,
    aerial = false,
    vimwiki = true,
    beacon = true,
    navic = {
      enabled = true,
      custom_bg = "NONE",
    },
    overseer = false,
  },
  color_overrides = {},
  highlight_overrides = {},
})

vim.cmd [[colorscheme catppuccin]]

-- Local Colors according to catppuccin - mocha
local crust = "#11111B"
local base = "#1E1E2E"
local mantle = "#181825"
local rosewater = "#F5E0DC"
local none = 'none'

--Cursorline Configuration
vim.api.nvim_set_hl(0, "CursorLine", { bg = crust })

-- Line Number of current Line - if cursorline is not active use LineNr
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = rosewater })

-- Highlight Search
-- vim.api.nvim_set_hl(0, "Search", { bg=rosewater })

-- Custom Color for Window Split Seperator
-- local vsfg = "#171b21"
-- local vsbg = "#242933"
vim.api.nvim_set_hl(0, "VertSplit", { fg = crust, bg = none })

-- Custom Color for TabLineFill
-- local tablinebg = "#1E232A"
-- vim.api.nvim_set_hl(0, "TabLineFill", { fg=tablinebg })
-- vim.api.nvim_set_hl(0, "TabLineFill", { fg=crust })

vim.api.nvim_set_hl(0, 'Normal', { bg = mantle })
