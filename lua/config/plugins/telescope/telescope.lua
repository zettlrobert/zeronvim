-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" }
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      pickers = {
        find_files = {
          find_command = { "rg", "--hidden", "--files" },
          theme = "ivy",
        },
        help_tags = {
          theme = "ivy",
        },
      },
      extensions = {
        fzf = {},
        file_browser = {
          theme = "ivy",
          hijack_netrw = false,
        }
      },
    })

    -- Load teelscope extensiosn
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")

    -- Help tags
    vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags, { desc = "Telescope help tags" })

    -- Search all files in current directory
    vim.keymap.set("n", "<space>fd", require("telescope.builtin").find_files, { desc = "Telescope find_files" })

    -- Open the neovim config files
    vim.keymap.set("n", "<space>en", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.stdpath("config"),
      })
    end, { desc = "Telescope open neovim configuration" })

    -- Search files of installed neovim plugins
    vim.keymap.set("n", "<space>ep", function()
      require("telescope.builtin").find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data")[1], "lazy"),
      })
    end, { desc = "Telescope search files of installed neovim plugins" })

    -- Setup Multigrep
    require("config.plugins.telescope.multigrep").setup()

    -- open file_browser with the path of the current buffer
    vim.keymap.set("n", "<space>eff", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

    -- Alternatively, using lua API
    vim.keymap.set("n", "<space>e", function()
      telescope.extensions.file_browser.file_browser()
    end, { desc = ":Telescope file_browser" })
  end,
}
