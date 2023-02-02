local M = {}

M.config = function()
	local null_ls = require("null-ls")
	local formatters = require("lvim.lsp.null-ls.formatters")
	formatters.setup({
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.eslint_d.with({
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
		}),
		null_ls.builtins.formatting.black.with({ extra_args = { "--fast", "--line-length", 80 } }),
		null_ls.builtins.formatting.isort.with({ extra_args = { "--profile", "black" } }),
		-- null_ls.builtins.formatting.prismaFmt,
		{ command = "stylua" },
		{ command = "rustfmt" },
		{ command = "gofmt" },
		{ command = "shfmt" },
		{ command = "asmfmt", filetypes = { "asm", "nasm", "masm" } },
	})

	local linters = require("lvim.lsp.null-ls.linters")
	linters.setup({
		null_ls.builtins.diagnostics.eslint_d.with({
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
		}),
		null_ls.builtins.diagnostics.shellcheck,
		{ command = "flake8" },
		{ command = "qmllint" },
		{ command = "buf" },
		-- { command = "mypy" },
	})

	local actions = require("lvim.lsp.null-ls.code_actions")
	actions.setup({
		null_ls.builtins.code_actions.eslint_d.with({
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
		}),
		null_ls.builtins.code_actions.shellcheck,
	})
end

return M
