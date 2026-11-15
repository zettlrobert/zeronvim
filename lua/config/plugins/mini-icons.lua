--https://github.com/nvim-mini/mini.icons

return {
  "nvim-mini/mini.icons",
  version = "*",
  opts = {
    lsp = {
      copilot = { glyph = "", hl = "MiniIconsGreen" },
      -- Font-awesome microchip (nf-fa-microchip). Universally supported
      -- across older nerd-font versions; older codepoint than nf-md-brain.
      minuet = { glyph = "", hl = "MiniIconsYellow" },
      ollama = { glyph = "", hl = "MiniIconsYellow" },
    },
  },
  config = function(_, opts)
    local mini_icons = require("mini.icons")
    mini_icons.setup(opts)
    -- After setup: the mock forwards nvim-web-devicons calls to MiniIcons.get,
    -- which needs the configured icons.
    mini_icons.mock_nvim_web_devicons()
  end,
}
