local M = {}

M.config = function()
	require("mason-tool-installer").setup({
		-- a list of all tools you want to ensure are installed upon
		-- start; they should be the names Mason uses for each tool
		ensure_installed = {
			-- debugers
			"chrome-debug-adapter",
			"delve",
			"debugpy",
			"node-debug2-adapter",
			"codelldb",

			-- lsp servers
			"bash-language-server",
			"ansible-language-server",
			"clangd",
			"gopls",
			"json-lsp",
			"kotlin-language-server",
			"lua-language-server",
			"pyright",
			"rust-analyzer",
			"solidity",
			"sqls",
			"html-lsp",
			"tailwindcss-language-server",
			"terraform-ls",
			"typescript-language-server",
			"vim-language-server",
			"yaml-language-server",

			-- formatters and linters
			"shfmt",
			"taplo",
			"buf",
			"stylua",
			"prettierd",
			"eslint_d",
			"flake8",
			"black",
			"isort",
			"ansible-lint",
			"fixjson",
			"beautysh", -- shell fmt
			"actionlint", -- github workflows linter
			"yamlfmt",
			-- you can pin a tool to a particular version
			-- { "golangci-lint", version = "1.47.0" },
			-- you can turn off/on auto_update per tool
			-- { "bash-language-server", auto_update = true },
		},

		-- if set to true this will check each tool for updates. If updates
		-- are available the tool will be updated. This setting does not
		-- affect :MasonToolsUpdate or :MasonToolsInstall.
		-- Default: false
		auto_update = false,

		-- automatically install / update on startup. If set to false nothing
		-- will happen on startup. You can use :MasonToolsInstall or
		-- :MasonToolsUpdate to install tools and check for updates.
		-- Default: true
		run_on_start = true,

		-- set a delay (in ms) before the installation starts. This is only
		-- effective if run_on_start is set to true.
		-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
		-- Default: 0
		start_delay = 0, -- 3 second delay
	})
end

return M
