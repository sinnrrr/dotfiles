return {
	"nvim-neotest/neotest",
	dependencies = {
		{
			"folke/which-key.nvim",
			opts = function(_, opts)
				require("which-key").add({ { "<leader>td", group = "debug" }, { "<leader>t", group = "test" } })
				return opts
			end,
		},
	},
	keys = function()
		return {
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run File",
			},
			{
				"<leader>tn",
				function()
					require("neotest").run.run()
				end,
				desc = "Run Nearest",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run_last()
				end,
				desc = "Re-run latest",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle Summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Show Output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle Output Panel",
			},
			{
				"<leader>tq",
				function()
					require("neotest").run.stop()
				end,
				desc = "Stop",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.attach()
				end,
				desc = "Attach",
			},
			{
				"<leader>tdn",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug nearest",
			},
			{
				"<leader>tdf",
				function()
					require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
				end,
				desc = "Debug file",
			},
			{
				"<leader>tdr",
				function()
					require("neotest").run.run_last({ strategy = "dap" })
				end,
				desc = "Re-run latest with debug",
			},
		}
	end,
	opts = {
		floating = {
			max_width = 0.8,
			max_height = 0.8,
		},
		output = {
			open_on_run = false,
		},
		quickfix = {
			enabled = false,
		},
		discovery = {
			concurrent = 1,
			enabled = true,
		},
		summary = {
			follow = true,
			expand_errors = false,
			mappings = {
				attach = "a",
				expand = { "l", "h" }, -- any letter just toggles, keep both
				expand_all = { "L", "H" },
				jumpto = "<CR>",
				output = "o",
				short = "s",
				run = "r",
				debug = "d",
				debug_marked = "D",
				mark = "t",
				watch = "W",
				run_marked = "R",
				clear_marked = "c",
				stop = "q",
				next_failed = "]e",
				prev_failed = "[e",
				target = "T",
				clear_target = "C",
			},
		},
	},
}
