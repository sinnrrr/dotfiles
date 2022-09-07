vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
lvim.plugins = {
	{ "ptzz/lf.vim" },
	{ "voldikss/vim-floaterm" },
	{ "lunarvim/colorschemes" },
	{ "folke/tokyonight.nvim" },
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	config = function()
	-- 		require("onedark").setup({
	-- 			toggle_style_key = "<Leader>aka",
	-- 		})
	-- 	end,
	-- },
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach()
		end,
		event = "BufRead",
	},
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
	{ "princejoogie/tailwind-highlight.nvim" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"turbio/bracey.vim",
		run = "npm install --prefix server",
	},
	{
		"xuhdev/vim-latex-live-preview",
		ft = "tex",
	},
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"michaelb/sniprun",
		run = "bash ./install.sh",
		disable = not lvim.builtin.sniprun.active,
		config = function()
			require("sniprun").setup({
				display = {
					"VirtualTextOk",
					"VirtualTextErr",
				},
				live_mode_toggle = "enable",
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				easing_function = "cubic",
			})
		end,
		event = "BufRead",
	},
	{
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("plugins.dapui").config()
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("plugins.dap-virtual-text").config()
		end,
	},
	{
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
		},
		config = function()
			require("plugins.neotest").config()
		end,
	},
	{ "lambdalisue/suda.vim" },
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
