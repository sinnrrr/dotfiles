lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.treesitter.ignore_install = { "phpdoc", "proto" }

-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
lvim.builtin.treesitter.textobjects = {
	move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = {
			["]f"] = "@function.outer",
			["]c"] = "@class.outer",
		},
		goto_next_end = {
			["]F"] = "@function.outer",
			["]C"] = "@class.outer",
		},
		goto_previous_start = {
			["[f"] = "@function.outer",
			["[c"] = "@class.outer",
		},
		goto_previous_end = {
			["[F"] = "@function.outer",
			["[C"] = "@class.outer",
		},
	},
	select = {
		enable = true,
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		keymaps = {
			-- You can use the capture groups defined in textobjects.scm
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["ai"] = "@conditional.outer",
			["ii"] = "@conditional.inner",
			["a/"] = "@comment.outer",
			["i/"] = "@comment.inner",
			["ab"] = "@block.outer",
			["ib"] = "@block.inner",
		},
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			["@class.outer"] = "<c-v>", -- blockwise
		},
	},
}

lvim.builtin.treesitter.autotag = { enable = true }

lvim.builtin.treesitter.indent.disable = { "python" }
lvim.builtin.treesitter.rainbow = {
	enable = true,
	disable = { "html", "jsx" },
	colors = {
		"Gold",
		"Orchid",
		"DodgerBlue",
		-- "Cornsilk",
		-- "Salmon",
		-- "LawnGreen",
	},
}
