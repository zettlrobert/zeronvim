--https://github.com/LunarVim/breadcrumbs.nvim
return {
  "LunarVim/breadcrumbs.nvim",
  config = function()
    local breadcrumbs = require("breadcrumbs")

    breadcrumbs.setup()
  end
}
