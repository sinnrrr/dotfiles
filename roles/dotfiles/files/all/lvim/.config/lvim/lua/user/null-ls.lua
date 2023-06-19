local null_ls = require("null-ls")
local u = require("null-ls.utils")
local h = require("null-ls.helpers")
local formatters = require("lvim.lsp.null-ls.formatters")

local eslint_config = {
	prefer_local = "node_modules/.bin",
	condition = function(utils)
		return utils.root_has_file({
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			"eslintrc.yml",
			".eslintrc.json",
		})
	end,
}

formatters.setup({
	null_ls.builtins.formatting.prettierd.with({
		env = {
			PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
		},
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"css",
			"scss",
			"less",
			"html",
		},
	}),
	null_ls.builtins.formatting.eslint_d.with(eslint_config),
	{ name = "isort", prefer_local = ".venv/bin" },
	{
		name = "black",
		prefer_local = ".venv/bin",
		cwd = h.cache.by_bufnr(function(params)
			return u.root_pattern("pyproject.toml")(params.bufname)
		end),
	},
	{ name = "stylua" },
	{ name = "rustfmt" },
	{ name = "gofmt" },
	{ name = "qmlformat" },
	{ name = "buf" },
	{ name = "fixjson" },
	{ name = "google_java_format", filetypes = { "java" } },
	{ name = "terraform_fmt" },
	{ name = "beautysh" },
	{ name = "taplo" },
	{ name = "yamlfmt" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	null_ls.builtins.diagnostics.eslint_d.with(eslint_config),
	{ name = "flake8", prefer_local = ".venv/bin" },
	-- { name = "mypy", prefer_local = ".venv/bin" },
	{ name = "qmllint" },
	{ name = "buf" },
	{ name = "hadolint" },
	{ name = "terraform_validate" },
	{ name = "actionlint" },
})

local actions = require("lvim.lsp.null-ls.code_actions")
actions.setup({
	null_ls.builtins.code_actions.eslint_d.with(eslint_config),
	{ name = "refactoring" },
})
