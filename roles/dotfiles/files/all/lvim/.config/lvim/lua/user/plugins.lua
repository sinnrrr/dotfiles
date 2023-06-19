lvim.plugins = {
	-- copy over ssh
	{ "ojroques/vim-oscyank" },
	{
		"folke/trouble.nvim",
		name = "trouble",
		cmd = "TroubleToggle",
		config = function()
			require("user.trouble").config()
		end,
	},
	-- find and replace
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("user.spectre").config()
		end,
	},
	-- highlight hex color values
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("user.colorizer").config()
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "BufRead",
		config = function()
			require("user.gitlinker").config()
		end,
	},
	-- harpoon
	{
		"Keep-Simple/harpoon",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("user.harpoon").config()
		end,
	},
	{
		"RishabhRD/nvim-cheat.sh",
		dependencies = "RishabhRD/popfix",
		config = function()
			vim.g.cheat_default_window_layout = "vertical_split"
		end,
		lazy = true,
		cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
	},
	-- smart git wrapper
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
	},
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "microsoft/python-type-stubs" },
	{
		"lervag/vimtex",
		ft = "tex",
	},
	-- autoclose and autorename html/xml tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("user.autotag").config()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("user.outline").config()
		end,
	},
	-- Sudo save
	{ "lambdalisue/suda.vim" },
	-- :Codi [name] opens buffers with [name] language interpreter
	{
		"metakirby5/codi.vim",
		cmd = "Codi",
		config = function()
			require("user.codi").config()
		end,
	},
	-- Live markdown preview in browser
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		cmd = { "MarkdownPreview" },
		dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		config = function()
			require("persistence").setup()
		end,
	},
	-- gx opens links
	{
		"felipec/vim-sanegx",
		event = "BufRead",
	},
	-- lf wrapper (my fork with current file focus fix)
	{
		"Keep-Simple/lf.nvim",
		config = function()
			require("user.lf").config()
		end,
		dependencies = { "plenary.nvim", "toggleterm.nvim" },
	},
	-- collaborative editing
	{
		"jbyuki/instant.nvim",
		config = function()
			require("user.instant").config()
		end,
	},
	-- remember cursor position of the buffers
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{ "rcarriga/cmp-dap" },
	{
		"mfussenegger/nvim-dap",
		name = "dap",
		config = function()
			require("user.dap")
		end,
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		config = function()
			require("persistent-breakpoints").setup({
				load_breakpoints_event = { "BufReadPost" },
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		name = "dapui",
		config = function()
			require("user.dapui").config()
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		name = "dap-virtual-text",
		config = function()
			require("user.dap-virtual-text").config()
		end,
	},
	-- test runner with dap integration
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("user.neotest").config()
		end,
	},
	-- show lsp server progress
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	-- show code context at the top of the buffer
	"nvim-treesitter/nvim-treesitter-context",
	-- tree sitter based textobjects
	"nvim-treesitter/nvim-treesitter-textobjects",
	-- mason is lsp/debugger/formatters/linters installer, this is config
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("user.mason").config()
		end,
	},

	-- language specific
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("user.rust-tools").config()
		end,
		ft = { "rust", "rs" },
	},
	{
		"peterhoeg/vim-qml",
		event = "BufRead",
		ft = { "qml" },
	},
	{
		"jose-elias-alvarez/typescript.nvim",
	},
	{ "mfussenegger/nvim-jdtls" },
	-- telescope extension for ripgrep args
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("user.refactoring").config()
		end,
	},
	-- ai autocompletions
	{
		"gelfand/copilot.vim",
		dependencies = "hrsh7th/cmp-copilot",
		config = function()
			require("user.copilot").config()
		end,
		enabled = false,
	},
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
		enabled = false,
	},
	-- vim training
	{ "ThePrimeagen/vim-be-good" },
	-- tmux
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"vim-scripts/LargeFile",
	},
}
