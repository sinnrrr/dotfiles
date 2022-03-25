local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "prettier",
    extra_args = { "--print-with", "100" },
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "markdown",
    },
  },
  rust = { "rustfmt" },
  qml = { "qmlformat" },
  lua = { "stylua" }
}
