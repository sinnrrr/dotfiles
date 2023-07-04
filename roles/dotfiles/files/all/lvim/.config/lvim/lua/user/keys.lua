lvim.leader = ","

lvim.builtin.terminal.open_mapping = [[<c-\>]]

-- ignore project.nvim mapping, use only packer
local whk = lvim.builtin.which_key.mappings
local whk_v = lvim.builtin.which_key.vmappings
whk["P"] = whk["p"]
whk["p"] = nil
whk[";"] = nil
lvim.lsp.buffer_mappings.normal_mode["gr"] = nil

vim.o.timeoutlen = 150
vim.g.tmux_navigator_no_mappings = 1
lvim.keys.normal_mode = {
	["<M-h>"] = "<cmd>TmuxNavigateLeft<cr>",
	["<M-l>"] = "<cmd>TmuxNavigateRight<cr>",
	["<M-j>"] = "<cmd>TmuxNavigateDown<cr>",
	["<M-k>"] = "<cmd>TmuxNavigateUp<cr>",
	["[d"] = "<cmd>lua vim.diagnostic.goto_prev()<cr>",
	["]d"] = "<cmd>lua vim.diagnostic.goto_next()<cr>",
	["[e"] = "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
	["]e"] = "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
	["gr"] = "<cmd>TroubleToggle lsp_references<cr>",
	["gS"] = "<cmd>setlocal spell!<cr>",
	["<C-l>"] = "<cmd>BufferLineCycleNext<cr>",
	["<C-h>"] = "<cmd>BufferLineCyclePrev<cr>",
	["<C-S-l>"] = "<cmd>BufferLineMoveNext<cr>",
	["<C-S-h>"] = "<cmd>BufferLineMovePrev<cr>",
	["<C-q>"] = "<cmd>BufferKill<cr>",
	["<C-d>"] = "<C-d>zz",
	["<C-u>"] = "<C-u>zz",
	["n"] = "nzz",
	["N"] = "Nzz",
}

vim.cmd([[
    " backward search
     nnoremap \ ,
    "leader instead of , is not working for some reason
    "paste and ignore deleted content
     xnoremap ,p "_dP
    "delete completly (to the null register)
     " nnoremap ,d "_d
     " vnoremap ,d "_d
    "copy to the clipboard
     nnoremap ,y "+y
     vnoremap ,y "+y
]])

whk["LC"] = { "<cmd>LvimCacheReset<cr>", "Lvim cache reset" }
whk["lR"] = { "<cmd>LspRestart<cr>", "Restart lsp" }
whk["W"] = {
	name = "Save options",
	s = { "<cmd>SudaWrite<cr>", "sudo save" },
	n = { "<cmd>noautocmd w<cr>", "no format save" },
	a = { "<cmd>wa<cr>", "save all" },
	t = { "<cmd>LvimToggleFormatOnSave<cr>", "Toggle format on save" },
	N = { "<cmd>noautocmd wa<cr>", "no format save all" },
}

whk["C"] = {
	name = "ChatGPT",
	d = { "<cmd>ChatGPT<cr>", "Dialogue" },
	a = { "<cmd>ChatGPTActAs<cr>", "Act as" },
	e = { "<cmd>ChatGPTEditWithInstructions<cr>", "Edit with instructions" },
	r = {
		name = "Run",
		g = { "<cmd>ChatGPTRun grammar_correction<cr>", "Grammar correction" },
		t = { "<cmd>ChatGPTRun translate<cr>", "Translate" },
		k = { "<cmd>ChatGPTRun keywords<cr>", "Keywords" },
		d = { "<cmd>ChatGPTRun docstring<cr>", "Docstring" },
		a = { "<cmd>ChatGPTRun add_tests<cr>", "Add tests" },
		o = { "<cmd>ChatGPTRun optimize_code<cr>", "Optimize code" },
		s = { "<cmd>ChatGPTRun summarize<cr>", "Summarize" },
		f = { "<cmd>ChatGPTRun fix_bugs<cr>", "Fix bugs" },
		e = { "<cmd>ChatGPTRun explain_code<cr>", "Explain code" },
		r = { "<cmd>ChatGPTRun roxygen_edit<cr>", "Roxygen edit" },
		c = { "<cmd>ChatGPTRun code_readability_analysis<cr>", "Code readability analysis" },
	},
}

whk["c"] = {
	name = "Copilot",
	t = { "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<cr>", "Toggle" },
	p = { "<cmd>Copilot panel<cr>", "Panel" },
}

whk["T"] = {
	name = "Trouble",
	r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
	f = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "Location list" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

whk["gy"] = { "<cmd>lua require'gitlinker'.get_buf_range_url('n')<cr>", "Copy link" }
whk["gm"] = { "<cmd>Git<cr>", "Git menu" }

whk["m"] = { "<cmd>MarkdownPreviewToggle<cr>", "Live Markdown" }

whk["lo"] = { "<cmd>SymbolsOutline<cr>", "Outline" }

whk["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

whk["r"] = {
	name = "Replace",
	r = { "<cmd>lua require('spectre').open()<cr>", "open" },
	w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "word in project" },
	f = { "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>", "word in file" },
}

whk["Y"] = { ":OSCYankVisual<cr>", "OSC52 Copy (for ssh)", mode = "v" }
whk["e"] = { "<cmd>Lf<cr>", "Explorer" }
whk["s"]["t"] = { "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args()<cr>", "Text" }

local _, trouble = pcall(require, "trouble.providers.telescope")
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
		["<C-q>"] = trouble.open_with_trouble,
	},
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-q>"] = trouble.open_with_trouble,
	},
}

whk["t"] = {
	name = "Test Runner",
	f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run file" },
	n = { "<cmd>lua require('neotest').run.run()<cr>", "Run nearest" },
	r = { "<cmd>lua require('neotest').run.run_last()<cr>", "Re-run latest" },
	q = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop nearest" },
	s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Toogle Summary" },
	o = { "<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>", "Show output" },
	a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach to nearest" },
	d = {
		name = "Debug",
		n = { "<cmd>lua require('neotest').run.run({ strategy='dap' })<cr>", "Debug nearest" },
		f = { "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), strategy='dap' })<cr>", "Debug file" },
		r = { "<cmd>lua require('neotest').run.run_last({ strategy='dap' })<cr>", "Re-run latest with debug" },
	},
}

whk["d"] = {
	name = "Debug",
	t = { "<cmd>PBToggleBreakpoint<cr>", "Toggle Breakpoint" },
	l = {
		"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
		"Toggle Log point",
	},
	T = {
		"<cmd>PBSetConditionalBreakpoint<cr>",
		"Toggle conditional Breakpoint",
	},
	B = { "<cmd>PBClearAllBreakpoints<cr>", "Clear all breakpoints" },
	b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
	c = { "<cmd>lua require'dap'.continue()<cr>", "Start/Continue" },
	C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
	g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
	i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
	o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
	u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
	-- With new lvim autocommand to hide repl, no longer needed
	-- R = { "<cmd>lua require'dap'.repl.close()<cr>", "Close Repl" },
	q = { "<cmd>lua require'dap'.terminate()<cr>", "Quit" },
	U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
}

whk["R"] = {
	name = "Refactor",
	i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline variable" },
	d = {
		name = "Debug Operations",
		p = { "<cmd>lua require('refactoring').debug.printf({below = false})<CR>", "Print function" },
		v = { "<cmd>lua require('refactoring').debug.print_var({ normal = true })<CR>", "Pring variable" },
		c = { "<cmd>lua require('refactoring').debug.cleanup({})<CR>", "Cleanup" },
	},
	b = { "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", "Extract block" },
	B = { "<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", "Extract block to file" },
}
whk_v["R"] = {
	name = "Refactor",
	f = { "<Esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract function" },
	F = {
		"<Esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
		"Extract function to file",
	},
	v = { "<Esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract variable" },
}

-- Harpoon
whk["a"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add Mark" }
whk["<leader>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon" }
-- whk["H"] = { "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", "Harpoon" }

whk["?"] = { "<cmd>Cheat<cr>", "Cheat.sh" }

local cmp = require("cmp")
lvim.builtin.cmp.mapping["<C-l>"] = cmp.mapping.complete()
lvim.builtin.cmp.mapping["<C-Space>"] = nil

local status, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not status then
	return
end
local telescope = require("telescope")

lvim.builtin.telescope.on_config_done = function()
	---@diagnostic disable-next-line: redundant-parameter
	telescope.setup({
		extensions = {
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				mappings = {
					i = {
						["<C-k>"] = lga_actions.quote_prompt(),
						["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					},
				},
			},
		},
	})
end
