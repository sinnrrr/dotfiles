local null_ls = require("null-ls")

null_ls.register({
  name = "nginxfmt",
  command = "nginxfmt",
  filetypes = { "nginx" },
  method = null_ls.methods.FORMATTING,
  generator = {
    fn = function()
      return nil
    end,
  },
})

local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
  {
    command = "prettier_d_slim",
    extra_args = { "--print-with", "100" },
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "markdown",
      "yaml",
    },
  },
  null_ls.builtins.formatting.eslint_d.with({
    prefer_local = "node_modules/.bin",
    condition = function(utils)
      return utils.root_has_file({
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        "eslintrc.yml",
        ".eslintrc.json",
      })
    end,
  }),
  {
    command = "yapf",
    filetypes = { "python" },
  },
  {
    command = "isort",
    filetypes = { "python" },
  },
  {
    command = "rustfmt",
    filetypes = { "rust" },
  },
  {
    command = "stylua",
    filetypes = { "lua" },
  },
  {
    command = "qmlformat",
    filetypes = { "qml" },
  },
  {
    command = "shfmt",
    filetypes = { "sh", "dotenv" },
  },
})
