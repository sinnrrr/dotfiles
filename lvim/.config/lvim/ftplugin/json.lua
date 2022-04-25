vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jsonls" })
require("lvim.lsp.manager").setup("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
})
