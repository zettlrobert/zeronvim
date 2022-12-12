local M = {}
local utils = require "zeronvim.utils"
local nvim_web_devicons = utils.protected_plugin_call("nvim-web-devicons")
local nvim_navic = utils.protected_plugin_call("nvim-navic")
local filename = utils.get_filename
local fileExtension = utils.get_file_extension

-- Autocommand to call winbar on different actions
vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" }, {
  callback = function()
    M.get_winbar()
  end,
})

-- Exclude Winbar for the following filetypes
M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
}

local prepare_filename = function()
  if not utils.is_input_empty(filename()) and nvim_web_devicons then
    local file_icon, file_icon_color = nvim_web_devicons.get_icon(
      filename(),
      fileExtension(),
      { default = true }
    )

    -- If there is no fileicon, provide a default
    if utils.is_input_empty(file_icon) then
      file_icon = ""
      -- file_icon_color = ""
    end

    local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

    return " " .. "%#" .. file_icon_color .. "#" .. file_icon .. "%*" .. " " .. "%#LineNr#" .. filename() .. "%*"
  end
end

local prepare_navic = function()
  -- If no nvim navic is loadeda
  if not nvim_navic then
    return ""
  end

  -- If nvim navic location can not be acessed
  if not nvim_navic.get_location() then
    return ""
  end

  if not nvim_navic.is_available or nvim_navic.get_location == "error" then
    return ""
  end

  if not utils.is_input_empty(nvim_navic.get_location()) then
    return " > " .. "%* " .. nvim_navic.get_location()
  else
    return ""
  end
end

local excludeWinbarOnFiletypes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  -- Do not display winbar if filetypes are execluded
  if excludeWinbarOnFiletypes() then
    return
  end

  local value = prepare_filename()
  local navic_added = false

  if not utils.is_input_empty(value) then
    local navic_value = prepare_navic()
    value = value .. " " .. navic_value

    if not utils.is_input_empty(navic_value) then
      navic_added = true
    end
  end

  if not utils.is_input_empty(value) and utils.get_buf_option("mod") then
    local mod = "%#LineNr#" .. "o" .. "%*"

    if navic_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  -- Enable Winbar
  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })

  if not status_ok then
    vim.notify("Could not set up winbar")
    return
  end

end

return M
