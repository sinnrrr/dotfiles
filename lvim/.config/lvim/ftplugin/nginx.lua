vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "nginxls" })
require("lvim.lsp.manager").setup("nginxls", {})
