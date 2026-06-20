return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep" },
		keys = {
			{ "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			current_line_blame = false,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function bmap(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				bmap("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(gs.next_hunk)
					return "<Ignore>"
				end, "Next Git hunk")

				bmap("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(gs.prev_hunk)
					return "<Ignore>"
				end, "Previous Git hunk")

				bmap("n", "<leader>gb", gs.blame_line, "Git blame line")
				bmap("n", "<leader>gp", gs.preview_hunk, "Preview Git hunk")
				bmap("n", "<leader>gr", gs.reset_hunk, "Reset Git hunk")
				bmap("n", "<leader>gs", gs.stage_hunk, "Stage Git hunk")
			end,
		},
	},
}
