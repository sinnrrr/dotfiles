lvim.builtin.treesitter.textobjects = {
  -- lsp_interop = {
  --      enable = true,
  --      border = 'single',
  --      peek_definition_code = {
  --        ["<leader>df"] = "@function.outer",
  --        ["<leader>dF"] = "@class.outer",
  --      },
  --    },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },
}

lvim.builtin.treesitter.autotag = {
  enable = true,
  disable = { "xml" },
}

lvim.builtin.treesitter.indent.disable = { "python" }
lvim.builtin.treesitter.rainbow = {
  enable = true,
  disable = { "html", "jsx" },
  colors = {
    "Gold",
    "Orchid",
    "DodgerBlue",
    -- "Cornsilk",
    -- "Salmon",
    -- "LawnGreen",
  },
}

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.hcl = {
  filetype = "hcl",
  "terraform",
}
