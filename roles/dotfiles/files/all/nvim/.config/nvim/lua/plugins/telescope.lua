local function get_git_dir()
	return vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h")
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		{
			"folke/which-key.nvim",
			opts = function(_, opts)
				require("which-key").add({ "<leader>F", group = "find/files" })
				return opts
			end,
		},
	},
	keys = function()
		return {
			-- find
			{
				"<leader>f",
				require("telescope.builtin").find_files,
				desc = "Find files (cwd)",
			},
			{
				"<leader>FF",
				function()
					require("telescope.builtin").git_files({ show_untracked = true })
				end,
				desc = "git files",
			},
			{
				"<leader>Fa",
				function()
					require("telescope.builtin").find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
				end,
				desc = "all cwd files (ignore, hidden)",
			},
			{
				"<leader>FA",
				function()
					require("telescope.builtin").find_files({
						hidden = true,
						no_ignore = true,
						no_ignore_parent = true,
						cwd = get_git_dir(),
					})
				end,
				desc = "all git files (ignore, hidden)",
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers({ sort_mru = true })
				end,
				desc = "Buffers",
			},
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
			-- search
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{
				"<leader>st",
				function()
					require("telescope.builtin").live_grep({
						additional_args = { "--hidden", "--glob=!.git/" },
					})
				end,
				desc = "Text",
			},
			{
				"<leader>sT",
				function()
					require("telescope.builtin").live_grep({
						cwd = get_git_dir(),
						additional_args = { "--hidden", "--glob=!.git/" },
					})
				end,
				desc = "Text (git)",
			},
			{
				"<leader>sA",
				function()
					require("telescope.builtin").live_grep({
						additional_args = { "--hidden", "--no-ignore" },
						cwd = get_git_dir(),
					})
				end,
				desc = "All text (git with ignore)",
			},
			{
				"<leader>sW",
				function()
					require("telescope.builtin").grep_string({
						additional_args = { "--hidden", "--glob=!.git/" },
						cwd = get_git_dir(),
					})
				end,
				desc = "Word (git)",
			},
			{
				"<leader>sw",
				function()
					require("telescope.builtin").grep_string({
						additional_args = { "--hidden", "--glob=!.git/" },
					})
				end,
				desc = "Word",
			},
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{
				"<leader>uC",
				LazyVim.pick("colorscheme", { enable_preview = true }),
				desc = "Colorscheme with preview",
			},
			{
				"<leader>ss",
				LazyVim.pick("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				LazyVim.pick("lsp_dynamic_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
		}
	end,
	opts = {
		pickers = {
			buffers = {
				mappings = {
					n = {
						["<C-d>"] = require("telescope.actions").delete_buffer,
						["<C-a>"] = require("telescope.actions").toggle_all,
					},
					i = {
						["<C-d>"] = require("telescope.actions").delete_buffer,
						["<C-a>"] = require("telescope.actions").toggle_all,
					},
				},
			},
		},
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<C-k>"] = require("telescope.actions").move_selection_previous,
					["<C-n>"] = require("telescope.actions").cycle_history_next,
					["<C-p>"] = require("telescope.actions").cycle_history_prev,
				},
				n = {
					["q"] = require("telescope.actions").close,
				},
			},
		},
	},
}
