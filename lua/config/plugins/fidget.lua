--https://github.com/j-hui/fidget.nvim
return {
  "https://github.com/j-hui/fidget.nvim",
  -- Shows LSP progress, which only exists once a client attaches.
  event = "LspAttach",
  config = function()
    local fidget = require("fidget")

    fidget.setup({})
  end
}
