--https://github.com/echasnovski/mini.icons

return {
  "echasnovski/mini.icons",
  version = "*",
  opts = function()
    local mini_icons = require("mini.icons").mock_nvim_web_devicons()

    return {
      lsp = {
        codeium = { glyph = "", hl = "MiniIconsAzure" },
        windsurf = { glyph = "", hl = "MiniIconsAzure" },
        copilot = { glyph = "", hl = "MiniIconsGreen" },
        -- Font-awesome microchip (nf-fa-microchip). Universally supported
        -- across older nerd-font versions; older codepoint than nf-md-brain.
        minuet = { glyph = "", hl = "MiniIconsYellow" },
        ollama = { glyph = "", hl = "MiniIconsYellow" },
      },
    }
  end,
}
