return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
					end

					map("n", "]h", gs.next_hunk, "Next Hunk")
					map("n", "[h", gs.prev_hunk, "Prev Hunk")

					map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
					map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
					map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, "Blame Line")
					map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Ghost Text Blame")
					map("n", "<leader>td", gs.toggle_deleted, "Toggle Deleted")
				end,
			})
		end,
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				kind = "split",
				integrations = {
					diffview = true,
				},
			})

			vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open Neogit Status" })
			vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { desc = "Git Commit" })
			vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { desc = "Git Pull" })
			vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { desc = "Git Push" })
		end,
	},
}
