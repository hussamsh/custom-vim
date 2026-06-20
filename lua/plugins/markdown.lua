return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		cmd = "RenderMarkdown",
		ft = { "markdown" },
		keys = {
			{ "<leader>mp", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown preview" },
			{ "<leader>me", "<cmd>RenderMarkdown expand<cr>", desc = "Expand Markdown preview" },
			{ "<leader>mc", "<cmd>RenderMarkdown contract<cr>", desc = "Contract Markdown preview" },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			file_types = { "markdown" },
		},
	},
}
