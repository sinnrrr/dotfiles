local wakatime = require("utils.wakatime")

lvim.builtin.lualine.sections.lualine_y = { wakatime.get_wakatime }
