return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
		{
			"folke/which-key.nvim",
			opts = function(_, opts)
				require("which-key").add({
					{ "<leader>R", group = "refactor" },
					{ "<leader>Rd", group = "prints" },
				})
				return opts
			end,
		},
	},
	opts = {
		-- prompt for return type
		prompt_func_return_type = {
			go = true,
			cpp = true,
			c = true,
			java = true,
		},
		-- prompt for function parameters
		prompt_func_param_type = {
			go = true,
			cpp = true,
			c = true,
			java = true,
		},
		printf_statements = {},
		print_var_statements = {},
	},
	keys = {
		{ "<leader>Ri", "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", desc = "Inline variable" },
		{ "<leader>Rdp", "<cmd>lua require('refactoring').debug.printf({below = false})<CR>", desc = "Print function" },
		{
			"<leader>Rdv",
			"<cmd>lua require('refactoring').debug.print_var({ normal = true })<CR>",
			desc = "Pring variable",
		},
		{ "<leader>Rdc", "<cmd>lua require('refactoring').debug.cleanup({})<CR>", desc = "Cleanup" },
		{ "<leader>Rb", "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", desc = "Extract block" },
		{
			"<leader>RB",
			"<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
			desc = "Extract block to file",
		},

		{
			"<leader>Rf",
			"<Esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>",
			desc = "Extract function",
			mode = "v",
		},
		{
			"<leader>RF",
			"<Esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
			desc = "Extract function to file",
			mode = "v",
		},
		{
			"<leader>Rv",
			"<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
			desc = "Extract variable",
			mode = "v",
		},
	},
}
