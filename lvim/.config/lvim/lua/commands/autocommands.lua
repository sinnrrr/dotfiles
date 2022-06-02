vim.api.nvim_create_autocmd("BufWrite", {
	pattern = { "*.ts", "*.tsx" },
	command = ":TSLspOrganizeSync",
})

vim.api.nvim_create_autocmd("VimResized", {
	pattern = { "*" },
	command = "FloatermUpdate",
})
