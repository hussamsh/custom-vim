return {
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false,
		opts = {
			style = "hydrogen",
			output_extension = "auto",
			force_ft = "python",
		},
	},
	{
		"benlubas/molten-nvim",
		build = ":UpdateRemotePlugins",
		lazy = false,
		keys = {
			{ "<leader>ni", "<cmd>MoltenInit<cr>", desc = "Initialize notebook kernel" },
			{ "<leader>nl", "<cmd>MoltenEvaluateLine<cr>", desc = "Run notebook line" },
			{ "<leader>nr", "<cmd>MoltenReevaluateCell<cr>", desc = "Re-run notebook cell" },
			{ "<leader>no", "<cmd>MoltenShowOutput<cr>", desc = "Show notebook output" },
			{ "<leader>nH", "<cmd>MoltenHideOutput<cr>", desc = "Hide notebook output" },
			{ "<leader>nd", "<cmd>MoltenDelete<cr>", desc = "Delete notebook output" },
			{ "<leader>nI", "<cmd>MoltenImportOutput<cr>", desc = "Import notebook outputs" },
			{ "<leader>nE", "<cmd>MoltenExportOutput<cr>", desc = "Export notebook outputs" },
			{ "<leader>nR", "<cmd>MoltenRestart<cr>", desc = "Restart notebook kernel" },
			{ "<leader>nq", "<cmd>MoltenDeinit<cr>", desc = "Stop notebook kernel" },
			{ "<leader>ne", "<cmd>MoltenEvaluateOperator<cr>", mode = "n", desc = "Run notebook operator" },
			{ "<leader>ne", ":<C-u>MoltenEvaluateVisual<cr>gv", mode = "v", desc = "Run notebook selection" },
		},
		init = function()
			vim.g.molten_auto_open_output = true
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_output_win_max_width = 90
			vim.g.molten_virt_text_output = true
			vim.g.molten_wrap_output = true
			vim.g.molten_image_provider = "none"
		end,
	},
	{
		"GCBallesteros/NotebookNavigator.nvim",
		keys = {
			{ "]n", function() require("notebook-navigator").move_cell("d") end, desc = "Next notebook cell" },
			{ "[n", function() require("notebook-navigator").move_cell("u") end, desc = "Previous notebook cell" },
			{ "<leader>nn", function() require("notebook-navigator").run_cell() end, desc = "Run notebook cell" },
			{ "<leader>nm", function() require("notebook-navigator").run_and_move() end, desc = "Run notebook cell and move" },
			{ "<leader>na", function() require("notebook-navigator").run_all_cells() end, desc = "Run all notebook cells" },
			{ "<leader>nb", function() require("notebook-navigator").add_cell_below() end, desc = "Add notebook cell below" },
			{ "<leader>nB", function() require("notebook-navigator").add_cell_above() end, desc = "Add notebook cell above" },
		},
		dependencies = {
			"benlubas/molten-nvim",
			"numToStr/Comment.nvim",
		},
		opts = {
			repl_provider = "molten",
			syntax_highlight = true,
		},
	},
}
