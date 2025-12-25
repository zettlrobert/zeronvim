-- https://github.com/nvim-lualine/lualine.nvim
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " " },
			colored = false,
			update_in_insert = false,
			always_visible = true,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " },
			cond = hide_in_width,
		}

		local function get_parent()
			-- 0 represents the current buffer
			local bufferPath = vim.api.nvim_buf_get_name(0)
			local parentDir = vim.fn.fnamemodify(bufferPath, ":h")

			-- vim.notify("bufferPath: " .. bufferPath)
			-- vim.notify("parentPath: " .. parentDir)

			-- check if current buffer is a file or a directory
			local isDir = vim.fn.isdirectory(bufferPath) == 1

			if isDir then
				return ""
			else
				return parentDir
			end
		end

		local function computeFilename()
			local filename = vim.fn.expand("%:t")
			local parentDir = get_parent()

			return parentDir .. "/" .. filename
		end

		local filename = computeFilename()

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "ayu_dark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {
						"http",
					},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				always_show_tabline = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", diff, diagnostics },
				lualine_c = { "filename", "searchcount" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "windows", "tabs", "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {
				lualine_a = {
					{
						"tabs",
						-- show_filename_only = true,
						mode = 1,
						use_mode_color = true,
					},
				},
			},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
