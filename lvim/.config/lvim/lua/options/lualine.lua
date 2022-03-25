local utils = require("utils")

lvim.builtin.lualine.sections.lualine_y = { utils.get_wakatime }
