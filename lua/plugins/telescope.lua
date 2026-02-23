return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		-- Keymaps
		local keymap = vim.keymap.set
		keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string under cursor" })
		keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find string under cursor" })
		keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find string under cursor" })
		keymap("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find string under cursor" })
		keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find string under cursor" })
		keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string under cursor" })
	end,
}
