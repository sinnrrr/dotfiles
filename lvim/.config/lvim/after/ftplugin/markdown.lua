require("lvim.lsp.manager").setup("prosemd_lsp", {
	on_attach = function(_client, bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", ":TableFormat<CR>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", ":MarkdownPreview<CR>", {})
	end,
})
