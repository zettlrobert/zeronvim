return {}
--   "nvim-neorg/neorg",
--   tag = "v7.0.0",
--   build = ":Neorg sync-parsers",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   config = function()
--     require("neorg").setup({
--       load = {
--         ["core.defaults"] = {}, -- Loads default behaviour
--         ["core.concealer"] = {
--           config = {
--             icon_preset = "diamond",
--           },
--         }, -- Adds pretty icons to your documents
--         ["core.dirman"] = { -- Manages Neorg workspaces
--           config = {
--             workspaces = {
--               zettlrobert = "~/notes/zettl",
--               zerodev = "~/notes/zerodev-solutions",
--               mobilehead = "~/notes/mobilehead",
--             },
--             default_workspace = "zettlrobert",
--           },
--         },
--         ["core.summary"] = {},
--         ["core.export"] = {
--           export_dir = "~/Downloads/",
--           config = {
--             extensions = { "all" },
--           },
--         },
--       },
--     })
--   end,
-- }
