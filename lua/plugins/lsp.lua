return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason").setup()

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"php",
				},
			})

			vim.lsp.config("yamlls", {
				filetypes = { "yaml" },
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"cssls",
					"html",
					"intelephense",
					"jsonls",
					"lua_ls",
					"tailwindcss",
					"ts_ls",
					"yamlls",
				},
				automatic_enable = {
					exclude = { "stylua" },
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = "VeryLazy",
		cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
		opts = {
			ensure_installed = {
				"eslint_d",
				"prettier",
				"php-cs-fixer",
				"shfmt",
				"stylua",
				"tree-sitter-cli",
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
