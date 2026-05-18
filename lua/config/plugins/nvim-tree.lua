-- https://github.com/nvim-tree/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local icons = require("config.assets.icons")

    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_cursor = true,
      reload_on_bufenter = true,
      view = {
        -- width = { min = 45 } enables nvim-tree's adaptive size behavior
        -- (grow to fit content, never shrink below the minimum)
        width = { min = 45 },
        side = "right",
        preserve_window_proportions = true,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
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
      },
      hijack_directories = {
        enable = false,
        auto_open = false,
      },
      diagnostics = {
        debounce_delay = 50,
        icons = {
          hint = icons.Diagnostics.HINT,
          info = icons.Diagnostics.INFO,
          warning = icons.Diagnostics.WARN,
          error = icons.Diagnostics.ERROR,
        },
      },
      filesystem_watchers = {
        -- Override upstream default which excludes node_modules, build, etc.
        ignore_dirs = {},
      },
      filters = {
        -- Show git-ignored files in the tree (replaces legacy `git.ignore = false`)
        git_ignored = false,
      },
      ui = {
        confirm = {
          -- Replaces legacy `trash.require_confirm = true`
          trash = true,
        },
      },
    })
  end,
}
