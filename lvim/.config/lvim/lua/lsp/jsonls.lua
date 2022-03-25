vim.list_extend(lvim.lsp.override, { "jsonls" })
require("lvim.lsp.manager").setup("jsonls", {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})
