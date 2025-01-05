local utils = require("utils")
local icons = require("assets.icons")

-- Set the Window Titlte
local function set_window_title()
  local project_name = utils.get_project_name()
  local window_title = icons.Utils.project .. project_name

  vim.o.titlestring = window_title
end

set_window_title()
