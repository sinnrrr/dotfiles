vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
lvim.plugins = {
	{ "ptzz/lf.vim" },
	{ "voldikss/vim-floaterm" },
	{ "lunarvim/colorschemes" },
	{ "folke/tokyonight.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "wakatime/vim-wakatime" },
	{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
	{ "TovarishFin/vim-solidity" },
	{ "sohkai/syntastic-local-solhint" },
	{ "tyru/open-browser.vim" },
	{ "p00f/nvim-ts-rainbow" },
	{ "aklt/plantuml-syntax" },
	{ "scrooloose/vim-slumlord" },
	{ "weirongxu/plantuml-previewer.vim" },
	{ "pearofducks/ansible-vim" },
	{ "godlygeek/tabular" },
	{ "preservim/vim-markdown" },
	{ "ianding1/leetcode.vim" },
	{ "tpope/vim-surround" },
	{ "nicwest/vim-http" },
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	config = function()
	-- 		require("neoscroll").setup({
	-- 			easing_function = "cubic",
	-- 		})
	-- 	end,
	-- 	event = "BufRead",
	-- },
	{ "norcalli/nvim-colorizer.lua" },
	{
		"ruifm/gitlinker.nvim",
		config = function()
			require("gitlinker").setup({
				opts = {
					print_url = false,
				},
			})
		end,
		event = "BufRead",
	},
	{
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
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
}
