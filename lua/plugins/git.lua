return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep" },
		keys = {
			{ "<leader>gg", "<cmd>Git<cr>", desc = "Git status" },
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff workspace" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Git diff" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git history" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Git file history" },
		},
		opts = {
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
				},
				file_history = {
					layout = "diff2_horizontal",
				},
			},
			file_panel = {
				listing_style = "tree",
				win_config = {
					position = "left",
					width = 35,
				},
			},
			file_history_panel = {
				win_config = {
					position = "bottom",
					height = 16,
				},
			},
		},
	},
	{
		"isakbm/gitgraph.nvim",
		dependencies = {
			"sindrets/diffview.nvim",
		},
		keys = {
			{
				"<leader>gl",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "Git commit graph",
			},
		},
		opts = {
			git_cmd = "git",
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%Y-%m-%d %H:%M",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					vim.cmd("DiffviewOpen " .. commit.hash .. "^!")
				end,
				on_select_range_commit = function(from, to)
					vim.cmd("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
				end,
			},
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
