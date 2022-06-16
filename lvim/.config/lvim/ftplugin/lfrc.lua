vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "bashls" })
require("lvim.lsp.manager").setup("bashls")
