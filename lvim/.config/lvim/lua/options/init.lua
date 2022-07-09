require("options.alpha")
require("options.lualine")
require("options.notify")
require("options.nvimtree")
require("options.toggleterm")
require("options.treesitter")
require("options.lspconfig")
require("options.whichkey")
require("options.floaterm")

vim.o.guifont = "JetBrainsMono Nerd Font Mono"

lvim.log.level = "warn"

lvim.format_on_save = true
lvim.lint_on_save = true

lvim.colorscheme = "onedark"
lvim.builtin.project.detection_methods = { "lsp" }

vim.g.onedark_config = {
	style = "darker",
}
vim.g.tokyonight_style = "day"

lvim.leader = ","
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.lsp.float.focusable = true
lvim.lsp.diagnostics.float.focusable = true

lvim.lsp.automatic_servers_installation = true

vim.g.leetcode_browser = "chrome"
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_http_tempbuffer = 1

lvim.builtin.dap.active = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})
