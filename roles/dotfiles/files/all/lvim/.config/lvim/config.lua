lvim.format_on_save = true

lvim.colorscheme = "tokyonight-day"

require("user.keys")
require("user.plugins")
require("user.settings")
require("user.treesitter")
require("user.autocommands")
require("user.builtins")
require("user.null-ls")

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
	"clangd",
	"gopls",
	"rust_analyzer",
	"pyright",
	"pylyzer",
	"tsserver",
	"jdtls",
	"ansiblels",
})
