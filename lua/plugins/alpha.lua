-- https://github.com/goolord/alpha-nvim
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local icons = require("assets.icons")

    dashboard.section.header.val = {
      [[   ███████ ███████ ██████   ██████  ███    ██ ██    ██ ██ ███    ███   ]],
      [[      ███  ██      ██   ██ ██    ██ ████   ██ ██    ██ ██ ████  ████   ]],
      [[     ███   █████   ██████  ██    ██ ██ ██  ██ ██    ██ ██ ██ ████ ██   ]],
      [[    ███    ██      ██   ██ ██    ██ ██  ██ ██  ██  ██  ██ ██  ██  ██   ]],
      [[   ███████ ███████ ██   ██  ██████  ██   ████   ████   ██ ██      ██   ]],
    }
    dashboard.section.buttons.val = {
      dashboard.button("e", (icons.Dashboard.NEW_FILE .. "New file"), ":ene <BAR> startinsert <CR>"),
      dashboard.button(
        "<leader> ff",
        (icons.Dashboard.FIND_FILE .. "Telescope Find File"),
        ":Telescope find_files<CR>"
      ),
      dashboard.button("<leader> fg", (icons.Dashboard.LIVE_GREP .. "Telescope Live Grep"), ":Telescope live_grep<CR>"),
      dashboard.button("q", (icons.Dashboard.CLOSE .. "Quit NVIM"), ":qa<CR>"),
    }

    dashboard.config.opts.noautocmd = true

    vim.cmd([[autocmd User AlphaReady echo 'ready']])

    alpha.setup(dashboard.config)
  end,
}
