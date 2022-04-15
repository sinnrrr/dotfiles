vim.list_extend(lvim.lsp.override, { "rust_analyzer" })
lvim.plugins = {
	{ "ptzz/lf.vim" },
	{ "voldikss/vim-floaterm" },
	{ "lunarvim/colorschemes" },
	{ "folke/tokyonight.nvim" },
	{ "wakatime/vim-wakatime" },
	{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
	{ "TovarishFin/vim-solidity" },
	{ "sohkai/syntastic-local-solhint" },
	{ "styled-components/vim-styled-components" },
	{ "mg979/vim-visual-multi" },
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	},
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = require("plugins.bqf").config,
	},
	{
		"simrat39/rust-tools.nvim",
		config = require("plugins.rust_tools").config,
		ft = { "rust", "rs" },
	},
	{
		"peterhoeg/vim-qml",
		event = "BufRead",
		ft = { "qml" },
	},
}
