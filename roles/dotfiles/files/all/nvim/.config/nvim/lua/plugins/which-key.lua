return {
	"folke/which-key.nvim",
	opts_extend = { "prefixes" },
	opts = {
		prefixes = {
			mode = { "n", "v" },
			{ "g", group = "goto" },
			{ "]", group = "next" },
			{ "[", group = "prev" },
			{ "<leader><tab>", group = "tabs" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "debug" },
			{ "<leader>g", group = "git" },
			{ "<leader>gh", group = "hunks" },
			{ "<leader>s", group = "search" },
			{ "<leader>u", group = "ui" },
			{ "<leader>x", group = "diagnostics/quickfix" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		opts["spec"] = opts["prefixes"]
		wk.setup(opts)
	end,
}
