-- https://github.com/stevearc/oil.nvim
return {
  {
    "stevearc/oil.nvim",
    -- Plain name: mini.icons is configured in mini-icons.lua. An `opts` here
    -- would be merged into that spec as a second fragment.
    dependencies = { "nvim-mini/mini.icons" },
    -- Safe to lazy-load: default_file_explorer = false, so oil never has to
    -- take over directory buffers at startup.
    cmd = "Oil",
    opts = {
      default_file_explorer = false,
      columns = {
        "icon"
      },
      view_options = {
        show_hidden = true
      }
    },
  }
}
