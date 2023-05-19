local M = {}

M.config = function()
	require("neotest").setup({
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
				run_marked = "R",
				clear_marked = "c",
				stop = "q",
				next_failed = "]e",
				prev_failed = "[e",
				target = "T",
				clear_target = "C",
			},
		},
		adapters = {
			require("neotest-python")({
				args = { "-vv", "-s" },
				runner = "pytest",
				python = require("user.dap.python").get_python_path,
				dap = require("user.dap.python").get_dap_config({}),
			}),
			require("neotest-go"),
			require("neotest-jest")({
				jestCommand = "npm test --",
				jestConfigFile = "custom.jest.config.ts",
				-- env = { CI = true },
				cwd = function(path)
					return vim.fn.getcwd()
				end,
			}),
		},
	})
end

return M
