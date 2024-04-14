return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	opts = {
		settings = {
			save_on_toggle = true,
			ui_nav_wrap = false,
		},
	},
	init = function()
		local harpoon = require("harpoon")
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add harpoon mark" })

		vim.keymap.set("n", "<leader>,", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<S-h>", function()
			harpoon:list():prev()
		end, { desc = "Previous harpooned file" })
		vim.keymap.set("n", "<S-l>", function()
			harpoon:list():next()
		end, { desc = "Next harpooned file" })

		-- direct harpoon files
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Switch to harpoon 1" })
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Switch to harpoon 2" })
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Switch to harpoon 3" })

		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Switch to harpoon 4" })
		vim.keymap.set("n", "<leader>5", function()
			harpoon:list():select(5)
		end, { desc = "Switch to harpoon 5" })
		vim.keymap.set("n", "<leader>6", function()
			harpoon:list():select(6)
		end, { desc = "Switch to harpoon 6" })

		vim.keymap.set("n", "<leader>7", function()
			harpoon:list():select(7)
		end, { desc = "Switch to harpoon 7" })
		vim.keymap.set("n", "<leader>8", function()
			harpoon:list():select(8)
		end, { desc = "Switch to harpoon 8" })
		vim.keymap.set("n", "<leader>9", function()
			harpoon:list():select(9)
		end, { desc = "Switch to harpoon 9" })

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end
			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end
		vim.keymap.set("n", "<leader>Fh", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Harpoon files" })
	end,
}
