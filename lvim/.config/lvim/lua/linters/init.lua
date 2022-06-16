local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  -- {
  --   command = "eslint_d",
  --   filetypes = {
  --     "javascriptreact",
  --     "javascript",
  --     "typescriptreact",
  --     "typescript",
  --     "vue",
  --   },
  -- },
  {
    command = "flake8",
    filetypes = { "python" },
  },
  {
    command = "qmllint",
    filetypes = { "qml", "ui" },
  },
  {
    command = "yamllint",
    filetypes = { "yaml" },
  },
  {
    command = "shellcheck",
    filetypes = { "sh" },
  },
  {
    command = "hadolint",
    filetypes = { "dockerfile" },
  },
  {
    command = "vint",
    filetypes = { "vim" },
  },
})
