vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "ansiblels" })
require("lvim.lsp.manager").setup("ansiblels", {})
