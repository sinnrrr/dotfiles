-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "grammarly" })
-- require("lvim.lsp.manager").setup("grammarly", {})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "prosemd_lsp" })
require("lvim.lsp.manager").setup("prosemd_lsp", {
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", ":TableFormat<CR>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", ":MarkdownPreview<CR>", {})
	end,
})
