-- lvim.builtin.which_key.mappings["gg"] = { "<cmd>FloatermNew lazygit<cr>", "LazyGit" }

lvim.builtin.which_key.mappings["t"] = {
	name = "Test Runner",
	f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run file" },
	n = { "<cmd>lua require('neotest').run.run()<cr>", "Run nearest" },
	r = { "<cmd>lua require('neotest').run.run_last()<cr>", "Re-run latest" },
	q = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop nearest" },
	d = {
		name = "Debug",
		n = { "<cmd>lua require('neotest').run.run({ strategy='dap' })<cr>", "Debug nearest" },
		f = { "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), strategy='dap' })<cr>", "Debug file" },
		r = { "<cmd>lua require('neotest').run.run_last({ strategy='dap' })<cr>", "Re-run latest with debug" },
	},
	s = { "<cmd>lua require('neotest').summary.open()<cr>", "Toogle Summary" },
	o = { "<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>", "Show output" },
}

lvim.builtin.which_key.mappings["dB"] = {
	name = "Breakpoints",
	c = { "<cmd>lua require('dap').clear_breakpoints()<cr>", "Clear all breakpoints" },
	l = { "<cmd>lua require('dap').list_breakpoints()<cr>", "List breakpoints" },
}

lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

lvim.builtin.which_key.mappings["lt"] = {
	name = "Typescript",
	i = { "<cmd>TSLspImportAll<cr>", "Import All" },
	o = { "<cmd>TSLspOrganize<cr>", "Organize Imports" },
	r = { "<cmd>TSLspRenameFile<cr>", "Rename File" },
	c = { "<cmd>TSLspImportCurrent<cr>", "Import under cursor" },
	h = { "<cmd>TSLspToggleInlayHints<cr>", "Toggle hints" },
}

lvim.builtin.which_key.mappings["k"] = {
	name = "LeetCode",
	l = { "<cmd>LeetCodeList<cr>", "Browse problems" },
	t = { "<cmd>LeetCodeTest<cr>", "Run with default test" },
	s = { "<cmd>LeetCodeSubmit<cr>", "Submit the code" },
}

lvim.builtin.which_key.mappings["u"] = {
	name = "Utils",
	w = {
		name = "Window",
		v = { "<cmd>vsplit<cr>", "Vertical split" },
		h = { "<cmd>split<cr>", "Hotizontal split" },
	},
	W = {
		"<cmd>SudaWrite<cr>",
		"Sudo Save",
	},
	C = { "<cmd>LvimCacheReset<cr>", "Cache Reset" },
	l = {
		"<cmd>lua require'gitlinker'.get_buf_range_url('n')<cr>",
		"Copy link",
	},
	t = { "<cmd>TodoQuickFix<cr>", "Todos" },
	m = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
}
