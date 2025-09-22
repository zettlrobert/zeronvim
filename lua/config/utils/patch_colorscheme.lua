-- Manual adjustments to the color scheme
local crust = "#11111B"
local mantle = "#181825"
local rosewater = "#F5e0DC"
local none = "none"

---Customizations for the Catppuccin colorscheme
local function patchColors()
  local currentColorScheme = vim.g.colors_name

  vim.notify_once("Current colorscheme = " .. currentColorScheme, vim.log.levels.INFO)

  if currentColorScheme == "catppuccin-mocha" then
    -- Cursorline Configuration
    vim.api.nvim_set_hl(0, "CursorLine", { bg = crust })

    -- Line Number of current Line - if Cursorline is not active use LineNr
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = rosewater })

    -- Custom Color for Window Split Separator
    vim.api.nvim_set_hl(0, "VertSplit", { fg = crust, bg = none })

    -- Set Background Color
    vim.api.nvim_set_hl(0, "Normal", { bg = mantle })
  else
    return
  end
end

---Creates a command for patching colors
---At the moment just catppuccin-mocha needs patching
---@param opts vim.api.keyset.create_user_command.command_args
vim.api.nvim_create_user_command("PatchColors", function(opts)
  patchColors()
end, {
  nargs = 0,
})

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  callback = function()
    patchColors()
  end,
  group = vim.api.nvim_create_augroup("PatchColors", { clear = true }),
})
