local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
	{
		command = "prettier",
		extra_args = { "--print-with", "100" },
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescriptreact",
			"typescript",
			"json",
			"markdown",
		},
	},
	{
		command = "yapf",
		filetypes = { "python" },
	},
	{
		command = "isort",
		filetypes = { "python" },
	},
	{
		command = "rustfmt",
		filetypes = { "rust" },
	},
	{
		command = "stylua",
		filetypes = { "lua" },
	},
	{
		command = "qmlformat",
		filetypes = { "qml" },
	},
})
