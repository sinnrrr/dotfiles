vim.api.nvim_create_autocmd("BufWrite", {
  pattern = { "*.ts", "*.tsx" },
  command = ':silent exec "!TSLspOrganizeSync"',
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = { "*" },
  command = "FloatermUpdate",
})
