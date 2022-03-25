lvim.autocommands.custom_groups = {
  -- Organize typescript packages
  { "BufWrite", "*.ts,*.tsx", ":TSLspOrganizeSync" },

  -- -- Fix eslint errors
  -- { "BufWrite", "*.ts,*.tsx", ":EslintFixAll" },
}
