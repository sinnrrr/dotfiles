return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		{
			"folke/which-key.nvim",
			opts = function(_, opts)
				require("which-key").add({ "<leader>r", group = "search & replace" })
				return opts
			end,
		},
		{ "nvim-lua/plenary.nvim" },
	},
	cmd = "Spectre",
	lazy = true,
	opts = {
		color_devicons = true,
		highlight = {
			ui = "String",
			search = "DiffChange",
			replace = "DiffDelete",
		},
		mapping = {
			["toggle_line"] = {
				map = "dd",
				cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
				desc = "toggle item",
			},
			["enter_file"] = {
				map = "<cr>",
				cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
				desc = "open file",
			},
			["send_to_qf"] = {
				map = "<leader>rq",
				cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
				desc = "send all items to quickfix",
			},
			["show_option_menu"] = {
				map = "to",
				cmd = "<cmd>lua require('spectre').show_options()<CR>",
				desc = "show options",
			},
			["run_current_replace"] = {
				map = "<leader>rr",
				cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
				desc = "replace current line",
			},
			["run_replace"] = {
				map = "<leader>rR",
				cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
				desc = "replace all",
			},
			["change_view_mode"] = {
				map = "m",
				cmd = "<cmd>lua require('spectre').change_view()<CR>",
				desc = "change result view mode",
			},
			["toggle_live_update"] = {
				map = "tu",
				cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
				desc = "update when vim writes to file",
			},
			["toggle_ignore_case"] = {
				map = "ti",
				cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
				desc = "toggle ignore case",
			},
			["toggle_ignore_hidden"] = {
				map = "th",
				cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
				desc = "toggle search hidden",
			},
			["resume_last_search"] = {
				map = "<leader>rl",
				cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
				desc = "repeat last search",
			},
		},
		find_engine = {
			-- rg is map with finder_cmd
			["rg"] = {
				cmd = "rg",
				-- default args
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
					-- you can put any option you want here it can toggle with
					-- show_option function
				},
			},
			["ag"] = {
				cmd = "ag",
				args = {
					"--vimgrep",
					"-s",
				},
				options = {
					["ignore-case"] = {
						value = "-i",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
				},
			},
		},
		replace_engine = {
			["sed"] = {
				cmd = "sed",
				args = nil,
			},
			options = {
				["ignore-case"] = {
					value = "--ignore-case",
					icon = "[I]",
					desc = "ignore case",
				},
			},
		},
		default = {
			find = {
				--pick one of item in find_engine
				cmd = "rg",
				options = { "ignore-case" },
			},
			replace = {
				--pick one of item in replace_engine
				cmd = "sed",
			},
		},
		replace_vim_cmd = "cdo",
		is_open_target_win = true, --open file on opener window
		is_insert_mode = false, -- start open panel on is_insert_mode
		open_cmd = "noswapfile vnew",
	},
	keys = function()
		return {
			{
				"<leader>ro",
				function()
					require("spectre").open()
				end,
				desc = "open",
			},
			{
				"<leader>rw",
				function()
					require("spectre").open_visual({ select_word = true })
				end,
				desc = "open with word",
			},
			{
				"<leader>rf",
				function()
					require("spectre").open_file_search({ select_word = true })
				end,
				desc = "open in file",
			},
		}
	end,
}
