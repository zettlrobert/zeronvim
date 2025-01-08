local icons = require("config.assets.icons")

local function get_project_name()
  local project_name = string.match(vim.fn.getcwd(), "/(%w+)$")
  return project_name or vim.fn.getcwd()
end

local function generate_window_title()
  local project_name = get_project_name()

  return icons.titlestring .. project_name
end

vim.o.titlestring = generate_window_title()
