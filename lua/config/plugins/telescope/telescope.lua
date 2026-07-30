-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local telescope_builtin = require("telescope.builtin")
    local kd = require("config.utils.keymap_desc")
    local K, T = kd.KIND, kd.TOOL

    telescope.setup({
      pickers = {
        find_files = {
          find_command = { "rg", "--files" },
          theme = "ivy",
        },
        help_tags = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
        },
        live_grep = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {},
      },
    })

    -- Load teelscope extensiosn
    telescope.load_extension("fzf")

    -- Help tags
    vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {
      desc = kd.format(K.PICK, T.Telescope, "help tags"),
    })

    -- Telescope find files
    vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {
      desc = kd.format(K.PICK, T.Telescope, "files"),
    })

    -- Telescope hidden find files
    vim.keymap.set("n", "<leader>f.", function()
      telescope_builtin.find_files({
        find_command = { "rg", "--hidden", "--files" },
        theme = "ivy",
      })
    end, { desc = kd.format(K.PICK, T.Telescope, "files (including hidden)") })

    -- Search all open buffers
    vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {
      desc = kd.format(K.PICK, T.Telescope, "buffers"),
    })

    -- Live Grep
    vim.keymap.set("n", "<leader>fl", telescope_builtin.live_grep, {
      desc = kd.format(K.SEARCH, T.Telescope, "live grep"),
    })

    -- LSP pickers (results can be sent to qflist via <C-q> inside the picker)
    vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references, {
      desc = kd.format(K.PICK, T.Telescope, "LSP references"),
    })
    vim.keymap.set("n", "<leader>fd", telescope_builtin.lsp_definitions, {
      desc = kd.format(K.PICK, T.Telescope, "LSP definitions"),
    })
    vim.keymap.set("n", "<leader>fD", telescope_builtin.diagnostics, {
      desc = kd.format(K.PICK, T.Telescope, "diagnostics"),
    })

    -- Keymap picker (complements which-key: search by desc)
    vim.keymap.set("n", "<leader>fk", telescope_builtin.keymaps, {
      desc = kd.format(K.PICK, T.Telescope, "keymaps"),
    })

    -- Open the neovim config files — <leader>f namespace (find)
    vim.keymap.set("n", "<leader>fn", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.stdpath("config"),
      })
    end, { desc = kd.format(K.PICK, T.Telescope, "nvim config files") })

    -- Search files of installed neovim plugins
    vim.keymap.set("n", "<leader>fp", function()
      require("telescope.builtin").find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
      })
    end, { desc = kd.format(K.PICK, T.Telescope, "installed plugin files") })

    -- Setup Multigrep
    require("config.plugins.telescope.multigrep").setup()
  end,
}
