local M = {}

-- TODO:
-- 1) Spectre
-- 2) Colorizer
-- 3) Legendary

M.config = function()
	lvim.plugins = {
		-- lsp, linters and formatters installer
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			config = function()
				require("user.mason").config()
			end,
		},
		-- wakatime plugin for vim
		{
			"wakatime/vim-wakatime",
			disable = not lvim.builtin.wakatime,
		},
		-- show hints on arguments needed when writing a function
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("user/lsp_signature").config()
			end,
			event = { "BufRead", "BufNew" },
		},
		-- pretty list of todo comments
		{
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({})
			end,
			event = "BufRead",
		},
		-- copy git link to line in file
		{
			"ruifm/gitlinker.nvim",
			requires = "nvim-lua/plenary.nvim",
			event = "BufRead",
			config = function()
				require("user.gitlinker").config()
			end,
		},
		-- pretty list of diagnostic info
		{
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		},
		-- tree view of variables and functions
		{
			"simrat39/symbols-outline.nvim",
			config = function()
				require("symbols-outline").setup()
			end,
			event = "BufReadPost",
			disable = lvim.builtin.tag_provider ~= "symbols-outline",
		},
		-- seamless lf integration for floaterm
		{
			"ptzz/lf.vim",
			disable = not lvim.builtin.lf_integration,
		},
		-- terminal inside vim
		{
			"voldikss/vim-floaterm",
			disable = not lvim.builtin.lf_integration,
		},
		-- suggestions AI
		{
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			requires = "hrsh7th/nvim-cmp",
			config = function()
				local tabnine = require("cmp_tabnine.config")
				tabnine:setup({
					max_lines = 1000,
					max_num_results = 10,
					sort = true,
				})
			end,
			opt = true,
			event = "InsertEnter",
		},
		-- :Codi [name] opens buffers with [name] language interpreter
		{
			"metakirby5/codi.vim",
			cmd = "Codi",
			config = function()
				require("user.codi").config()
			end,
		},
		{
			"mfussenegger/nvim-dap",
			as = "dap",
			config = function()
				require("user.dap")
			end,
		},
		{
			"rcarriga/cmp-dap",
			disable = not lvim.builtin.debugger.active,
		},
		-- debugging ui
		{
			"rcarriga/nvim-dap-ui",
			as = "dapui",
			config = function()
				require("user.dapui").config()
			end,
			ft = { "python", "rust", "go" },
			event = "BufReadPost",
			-- requires = {
			-- 	{ "mfussenegger/nvim-dap" },
			-- },
			disable = not lvim.builtin.debugger.active,
		},
		-- displays info as virtual text while debugging
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("user.dap-virtual-text").config()
			end,
			disable = not lvim.builtin.debugger.active,
		},
		-- live markdown preview in browser with scroll tracking
		{
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = "markdown",
		},
		-- sets up rust workflow
		{
			"simrat39/rust-tools.nvim",
			config = function()
				require("user.rust_tools").config()
			end,
			ft = { "rust", "rs" },
		},
		-- diagnostic messages as virtual text
		{
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			config = function()
				require("lsp_lines").setup()
			end,
			event = "BufRead",
			disable = not lvim.builtin.lsp_lines,
		},
		-- show block on top in which you're in right now (if's, while's, etc.)
		{ "nvim-treesitter/nvim-treesitter-context" },
		-- -- find and replace
		-- {
		--   "windwp/nvim-spectre",
		--   event = "BufRead",
		--   config = function()
		--     require("spectre").config {}
		--   end,
		-- },
		-- -- highlight color code text in respective color
		-- {
		--   "norcalli/nvim-colorizer.lua",
		--   config = function()
		--     require("colorizer").config()
		--   end,
		--   event = "BufRead",
		-- },
		-- sessions
		{
			"folke/persistence.nvim",
			event = "BufReadPre",
			module = "persistence",
			config = function()
				require("persistence").setup({
					dir = vim.fn.expand(get_cache_dir() .. "/sessions/"), -- directory where session files are saved
					options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
				})
			end,
		},
		-- typescript workflow
		{
			"jose-elias-alvarez/typescript.nvim",
			ft = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			opt = true,
			event = { "BufReadPre", "BufNew" },
			config = function()
				require("user.typescript").config()
			end,
		},
		-- test runner
		{
			"nvim-neotest/neotest",
			config = function()
				require("user.neotest").config()
			end,
			requires = {
				{ "nvim-neotest/neotest-go" },
				{ "nvim-neotest/neotest-python" },
				{ "nvim-neotest/neotest-plenary" },
				{ "rouge8/neotest-rust" },
			},
			-- opt = true,
			-- event = { "BufEnter *_test.*,*_spec.*,test_*.*" },
			disable = not (lvim.builtin.test_runner.active and lvim.builtin.test_runner.runner == "neotest"),
		},
		-- sql completion for vim-dadbod
		{
			"kristijanhusak/vim-dadbod-completion",
			disable = not lvim.builtin.sql_integration.active,
		},
		-- vim-dadbod ui to manage DBs and tables
		{
			"kristijanhusak/vim-dadbod-ui",
			cmd = {
				"DBUIToggle",
				"DBUIAddConnection",
				"DBUI",
				"DBUIFindBuffer",
				"DBUIRenameBuffer",
			},
			setup = function()
				vim.g.db_ui_use_nerd_fonts = 1
				vim.g.db_ui_show_database_icon = 1
			end,
			requires = {
				{
					"tpope/vim-dadbod",
					opt = true,
				},
			},
			opt = true,
			disable = not lvim.builtin.sql_integration.active,
		},
		-- smooth scroll
		{
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({
					easing_function = "quadratic",
				})
			end,
			event = "BufRead",
			disable = lvim.builtin.smooth_scroll ~= "neoscroll",
		},
		-- smooth scroll
		{
			"declancm/cinnamon.nvim",
			config = function()
				require("cinnamon").setup({
					default_keymaps = true,
					default_delay = 4,
					extra_keymaps = true,
					extended_keymaps = false,
					centered = true,
					scroll_limit = 100,
				})
			end,
			event = "BufRead",
			disable = lvim.builtin.smooth_scroll ~= "cinnamon",
		},
		-- -- fancy git diff view
		-- {
		-- 	"sindrets/diffview.nvim",
		-- 	opt = true,
		-- 	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		-- 	module = "diffview",
		-- 	keys = "<leader>gd",
		-- 	setup = function()
		-- 		require("which-key").register({ ["<leader>gd"] = "diffview: diff HEAD" })
		-- 	end,
		-- 	config = function()
		-- 		require("diffview").setup({
		-- 			enhanced_diff_hl = true,
		-- 			key_bindings = {
		-- 				file_panel = { q = "<Cmd>DiffviewClose<CR>" },
		-- 				view = { q = "<Cmd>DiffviewClose<CR>" },
		-- 			},
		-- 		})
		-- 	end,
		-- },
		-- faster filetype detection for vim
		{
			"nathom/filetype.nvim",
			config = function()
				require("user.filetype").config()
			end,
		},
		-- harpoon
		{ "Keep-Simple/harpoon", requires = "nvim-lua/plenary.nvim" },
		{
			"RishabhRD/nvim-cheat.sh",
			requires = "RishabhRD/popfix",
			config = function()
				vim.g.cheat_default_window_layout = "vertical_split"
			end,
			opt = true,
			cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
		},
		-- file loading progress
		{
			"j-hui/fidget.nvim",
			config = function()
				require("user.fidget_spinner").config()
			end,
		},
		-- better c/cpp workflow with inline hints and compiler configuration
		{
			"p00f/clangd_extensions.nvim",
			config = function()
				require("user.clangd_extensions").config()
			end,
			ft = { "c", "cpp", "objc", "objcpp" },
		},
		-- support for editorconfig files
		{
			"editorconfig/editorconfig-vim",
			event = "BufRead",
		},
		-- crates management
		{
			"saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("crates").setup({})
			end,
		},
		-- {
		--   "mrjones2014/legendary.nvim",
		--   config = function()
		--     require("user.legendary").config()
		--   end,
		-- },
		-- refactoring capabilities
		{
			"ThePrimeagen/refactoring.nvim",
			ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
			event = "BufRead",
			config = function()
				require("refactoring").setup({})
			end,
		},
	}
end

return M
