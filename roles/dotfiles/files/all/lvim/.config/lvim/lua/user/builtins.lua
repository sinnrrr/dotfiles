lvim.transparent_window = false
lvim.debug = true
lvim.log.level = "warn"

lvim.builtin.comment.active = true
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

lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.gitsigns.opts.current_line_blame = true

local whk_presets = lvim.builtin.which_key.setup.plugins.presets
whk_presets.z = true
whk_presets.windows = true
lvim.builtin.which_key.setup.ignore_missing = false

lvim.builtin.project.detection_methods = { "pattern", "lsp" }
lvim.builtin.project.patterns =
	{ ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", ".root", "pyproject.toml" }

lvim.builtin.telescope.pickers.find_files = { hidden = true, no_ignore = true }

lvim.lsp.null_ls.setup = {
	debug = false,
}
