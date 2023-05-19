lvim.transparent_window = false
lvim.debug = true
lvim.log.level = "warn"

lvim.builtin.terminal.active = true
lvim.builtin.project.active = true -- keep enabled for setting cwd correctly
lvim.builtin.dap.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.lir.active = false
lvim.builtin.indentlines.active = false
lvim.builtin.illuminate.active = false
lvim.builtin.nvimtree.active = false

lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.shading_factor = 1

lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.cmp.completion.autocomplete = false
lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.gitsigns.opts.current_line_blame = true

local whk_presets = lvim.builtin.which_key.setup.plugins.presets
whk_presets.z = true
whk_presets.windows = true

lvim.builtin.project.detection_methods = { "pattern", "lsp" }
lvim.builtin.project.patterns =
	{ ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", ".root", "pyproject.toml" }

lvim.builtin.telescope.pickers.find_files = { hidden = true, no_ignore = true }

lvim.lsp.null_ls.setup = {
	root_dir = function()
		return nil
	end,
}

local status, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not status then
	return
end
local telescope = require("telescope")

lvim.builtin.telescope.on_config_done = function()
	telescope.setup({
		extensions = {
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				-- define mappings, e.g.
				mappings = {
					-- extend mappings
					i = {
						["<C-k>"] = lga_actions.quote_prompt(),
						["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					},
				},
				-- ... also accepts theme settings, for example:
				-- theme = "dropdown", -- use dropdown theme
				-- theme = { }, -- use own theme spec
				-- layout_config = { mirror=true }, -- mirror preview pane
			},
		},
	})
end
