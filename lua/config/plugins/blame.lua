--https://github.com/FabijanZulj/blame.nvim
return {
  "FabijanZulj/blame.nvim",
  config = function()
    local blame = require("blame")

    blame.setup()
  end,
}
