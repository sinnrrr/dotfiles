local null_ls = require("null-ls")

null_ls.register({
	name = "nginxfmt",
	command = "nginxfmt",
	filetypes = { "nginx" },
	method = null_ls.methods.FORMATTING,
	generator = {
		fn = function()
			return nil
		end,
	},
})

local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
	null_ls.builtins.formatting.prettier.with({
		-- condition = function(utils)
		--   return utils.root_has_file({ ".prettierrc", ".prettierrc.json" })
		-- end,
	}),
	null_ls.builtins.formatting.eslint_d.with({
		condition = function(utils)
			return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" })
		end,
		prefer_local = "node_modules/.bin",
	}),
	{
		command = "yapf",
		filetypes = { "python" },
		args = { "--style", "{based_on_style: google, column_limit: 79}" },
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
		command = "gofmt",
		filetypes = { "go" },
	},
	{
		command = "stylua",
		filetypes = { "lua" },
	},
	{
		command = "qmlformat",
		filetypes = { "qml" },
	},
	{
		command = "shfmt",
		filetypes = { "sh", "dotenv" },
	},
})
