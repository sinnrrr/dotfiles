vim.list_extend(lvim.lsp.override, { "clangd" })
require("lvim.lsp.manager").setup("clangd", {
	root_dir = {
		"*.pro",
	},
})
