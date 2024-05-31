return {
	"rolv-apneseth/tfm.nvim",
	lazy = false,
	opts = {
		-- Possible choices: "ranger" | "nnn" | "lf" | "vifm" | "yazi" (default)
		file_manager = "lf",
		replace_netrw = true,
		keybindings = {
			["<ESC>"] = "q",
			["<C-s>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.vsplit)<CR>",
			["<C-h>"] = "<C-\\><C-O>:lua require('tfm').set_next_open_mode(require('tfm').OPEN_MODE.split)<CR>",
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				require("tfm").open()
			end,
			desc = "Explorer",
		},
	},
}
