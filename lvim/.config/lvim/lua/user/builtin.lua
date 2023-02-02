local M = {}

M.config = function()
	-- General
	-- =========================================
	lvim.colorscheme = "tokyonight-storm"
	lvim.format_on_save = true

	-- Comment
	-- =========================================
	-- integrate with nvim-ts-context-commentstring
	lvim.builtin.comment.pre_hook = function(ctx)
		if not vim.tbl_contains({ "typescript", "typescriptreact" }, vim.bo.ft) then
			return
		end

		local comment_utils = require("Comment.utils")
		local type = ctx.ctype == comment_utils.ctype.line and "__default" or "__multiline"

		local location
		if ctx.ctype == comment_utils.ctype.block then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring({
			key = type,
			location = location,
		})
	end

	-- LSP
	-- =========================================
	vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
		"clangd",
		"dockerls",
		"gopls",
		"jdtls",
		"pyright",
		"rust_analyzer",
		"taplo",
		"texlab",
		"tsserver",
		"yamlls",
	})

	lvim.lsp.float.focusable = true
	lvim.lsp.diagnostics.float.focusable = true
	lvim.lsp.installer.setup.automatic_installation = false

	if lvim.builtin.lsp_lines then
		lvim.lsp.diagnostics.virtual_text = false
	end

	if lvim.builtin.debugger.active then
		-- this needed because dap comes with lunarvim out of the box
		-- we disable it and config it with our own config
		lvim.builtin.dap.active = false
		-- require("user.dap").config()
	end

	-- LF integration
	-- =========================================
	if lvim.builtin.lf_integration.active then
		require("user.lf").config()
	end

	-- Project
	-- =========================================
	lvim.builtin.project.active = true
	lvim.builtin.project.detection_methods = { "pattern", "lsp" }
	lvim.builtin.project.patterns =
		{ ".root", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", "pyproject.toml" }

	-- Treesitter
	-- =========================================
	lvim.builtin.treesitter.context_commentstring.enable = true
	local languages = vim.tbl_flatten({
		{ "bash", "c", "cmake", "comment", "cpp", "css", "dockerfile", "go" },
		{ "gomod", "graphql", "hcl", "help", "html", "javascript", "jsdoc" },
		{ "json", "jsonc", "latex", "lua", "make", "markdown", "php", "python" },
		{ "regex", "rust", "scss", "solidity", "swift", "query" },
		{ "toml", "tsx", "typescript", "vim", "vue", "yaml" },
	})
	lvim.builtin.treesitter.ensure_installed = languages
	lvim.builtin.treesitter.highlight.disable = { "org" }
	lvim.builtin.treesitter.highlight.aditional_vim_regex_highlighting = { "org" }
	lvim.builtin.treesitter.ignore_install = { "haskell", "norg" }

	-- Telescope
	-- =========================================
	lvim.builtin.telescope.defaults.file_ignore_patterns = {
		"vendor/*",
		"%.lock",
		"__pycache__/*",
		"%.sqlite3",
		"%.ipynb",
		"node_modules/*",
		"%.jpg",
		"%.jpeg",
		"%.png",
		"%.svg",
		"%.otf",
		"%.ttf",
		".git/",
		"%.webp",
		".dart_tool/",
		".github/",
		".gradle/",
		".idea/",
		".settings/",
		".vscode/",
		"__pycache__/",
		"build/",
		"env/",
		"gradle/",
		"node_modules/",
		"target/",
		"%.pdb",
		"%.dll",
		"%.class",
		"%.exe",
		"%.cache",
		"%.ico",
		"%.pdf",
		"%.dylib",
		"%.jar",
		"%.docx",
		"%.met",
		"smalljre_*/*",
		".vale/",
		"%.burp",
		"%.mp4",
		"%.mkv",
		"%.rar",
		"%.zip",
		"%.7z",
		"%.tar",
		"%.bz2",
		"%.epub",
		"%.flac",
		"%.tar.gz",
	}

	-- Terminal
	-- =========================================
	lvim.builtin.terminal.active = true
	lvim.builtin.terminal.direction = "horizontal"

	if lvim.builtin.winbar_provider ~= "navic" then
		lvim.builtin.breadcrumbs.active = false
	end
end

return M
