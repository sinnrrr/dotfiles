vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tflint" })
require("lvim.lsp.manager").setup("tflint", {})
