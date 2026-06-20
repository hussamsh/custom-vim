return {
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		keys = {
			{ "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python virtualenv" },
		},
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {},
	},
}
