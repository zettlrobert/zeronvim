--https://github.com/j-hui/fidget.nvim
return {
  "https://github.com/j-hui/fidget.nvim",
  enabled = true,
  config = function()
    local fidget = require("fidget")

    fidget.setup({})
  end
}
