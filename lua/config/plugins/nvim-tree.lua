-- https://github.com/nvim-tree/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  enabled = true,
  config = function()
    local nvim_tree = require("nvim-tree")
    local icons = require("config.assets.icons")

    nvim_tree.setup({
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = true,
      hijack_cursor = true,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      reload_on_bufenter = true,
      respect_buf_cwd = false,
      on_attach = "disable",
      select_prompts = false,
      view = {
        adaptive_size = true,
        centralize_selection = false,
        width = 45,
        side = "right",
        preserve_window_proportions = true,
        number = false,
        relativenumber = true,
        signcolumn = "yes",
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          symlink_arrow = icons.Tree.symlink_arrow,
          glyphs = {
            default = icons.Tree.default,
            symlink = icons.Tree.symlink,
            bookmark = icons.Tree.bookmark,
            folder = {
              arrow_closed = icons.Tree.Folder.ARROW_CLOSED,
              arrow_open = icons.Tree.Folder.ARROW_OPEN,
              default = icons.Tree.Folder.DEFAULT,
              open = icons.Tree.Folder.OPEN,
              empty = icons.Tree.Folder.EMPTY,
              empty_open = icons.Tree.Folder.EMPTY_OPEN,
              symlink = icons.Tree.Folder.SYMLINK,
              symlink_open = icons.Tree.Folder.SYMLINK_OPEN,
            },
            git = {
              unstaged = icons.Tree.Git.unstaged,
              staged = icons.Tree.Git.staged,
              unmerged = icons.Tree.Git.unmerged,
              renamed = icons.Tree.Git.renamed,
              untracked = icons.Tree.Git.untracked,
              deleted = icons.Tree.Git.deleted,
              ignored = icons.Tree.Git.ignored,
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = false,
        auto_open = false,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = icons.diagnostics.HINT,
          info = icons.diagnostics.INFO,
          warning = icons.diagnostics.WARN,
          error = icons.diagnostics.ERROR,
        },
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    })
  end,


}
