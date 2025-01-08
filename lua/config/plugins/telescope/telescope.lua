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

    telescope.setup({
      pickers = {
        find_files = {
          find_command = { "rg", "--hidden", "--files" },
          theme = "ivy",
        },
        help_tags = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy"
        }
      },
      extensions = {
        fzf = {},
      },
    })

    -- Load teelscope extensiosn
    telescope.load_extension("fzf")

    -- Help tags
    vim.keymap.set("n", "<space>fh", telescope_builtin.help_tags, { desc = "Telescope help tags" })

    -- Search all files in current directory
    vim.keymap.set("n", "<space>ff", telescope_builtin.find_files, { desc = "Telescope find_files" })

    -- Search all open buffers
    vim.keymap.set("n", "<space>fb", telescope_builtin.buffers, { desc = "Telescope buffers" })

    -- Open the neovim config files
    vim.keymap.set("n", "<space>en", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.stdpath("config"),
      })
    end, { desc = "Telescope open neovim configuration" })

    -- Search files of installed neovim plugins
    vim.keymap.set("n", "<space>ep", function()
      require("telescope.builtin").find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
      })
    end, { desc = "Telescope search files of installed neovim plugins" })

    -- Setup Multigrep
    require("config.plugins.telescope.multigrep").setup()
  end,
}
