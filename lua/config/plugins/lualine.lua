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
			symbols = { error = " ", warn = " " },
			colored = false,
			update_in_insert = false,
			always_visible = true,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " },
			cond = hide_in_width,
		}

		-- AI provider status: per-provider glyphs, each colored via embedded
		-- statusline `%#HlGroup#` markup (see ai_toggle.statusline). Dim
		-- " off" text when everything is disabled.
		local ai_status = {
			function()
				return require("config.utils.ai_toggle").statusline()
			end,
		}

		-- Macro recording indicator: shows `● @<reg>` while `q<reg>` is capturing.
		-- Hidden otherwise via `cond`. Colored via the `Error` hl group so it
		-- stays high-visibility across colorschemes.
		local macro_recording = {
			function()
				local reg = vim.fn.reg_recording()
				return reg ~= "" and ("● @" .. reg) or ""
			end,
			cond = function()
				return vim.fn.reg_recording() ~= ""
			end,
			color = "Error",
		}

		-- Force lualine to refresh the moment recording starts/stops so the
		-- indicator doesn't lag behind the 1000ms refresh interval.
		vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
			group = vim.api.nvim_create_augroup("LualineMacroRefresh", { clear = true }),
			callback = function()
				-- Defer so reg_recording() sees the post-event state on Leave.
				vim.defer_fn(function()
					require("lualine").refresh()
				end, 50)
			end,
		})

		-- LSP client indicator: shows the buffer's filetype icon (from mini-icons)
		-- plus the count of attached LSP clients. mini-icons has proper filetype
		-- entries for lua/ts/py/etc. — no `?` fallback like the `lsp` category
		-- for unmapped server names. Compact, always renders something meaningful.
		local lsp_clients = {
			function()
				local n = #vim.lsp.get_clients({ bufnr = 0 })
				if n == 0 then
					return ""
				end
				local mi_ok, mi = pcall(require, "mini.icons")
				if not mi_ok then
					return "LSP:" .. n
				end
				local icon, hl = mi.get("filetype", vim.bo.filetype)
				return string.format("%%#%s#%s%%* %d", hl or "Comment", icon or "", n)
			end,
			cond = hide_in_width,
		}

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "ayu_dark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					-- Exclude filetypes that manage their own winbar. dap-ui
					-- uses winbar for the section title + controls (play/step
					-- buttons); lualine's global winbar would overwrite them.
					winbar = {
						"http",
						"dap-repl",
						"dapui_breakpoints",
						"dapui_console",
						"dapui_hover",
						"dapui_scopes",
						"dapui_stacks",
						"dapui_watches",
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
				lualine_c = { macro_recording, "filename", "searchcount" },
				lualine_x = { lsp_clients, ai_status, "encoding", "fileformat", "filetype" },
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
			-- Global winbar must be non-empty for lualine to wire up winbar
			-- rendering at all (lualine.lua line 598 checks `next(winbar)`).
			-- The compute function returns "" for non-qf windows, so this is
			-- a no-op everywhere except quickfix/loclist windows where it
			-- renders the heading. See lua/config/utils/qf_heading.lua.
			winbar = {
				lualine_c = {
					function()
						return require("config.utils.qf_heading").compute()
					end,
				},
			},
			inactive_winbar = {
				lualine_c = {
					function()
						return require("config.utils.qf_heading").compute()
					end,
				},
			},
			extensions = {},
		})
	end,
}
