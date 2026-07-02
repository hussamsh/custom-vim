return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		opts = {
			ensure_installed = {
				"bash",
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").setup()

			if vim.fn.executable("tree-sitter") == 1 then
				require("nvim-treesitter").install(opts.ensure_installed)
			else
				vim.schedule(function()
					vim.notify(
						"tree-sitter CLI missing; Mason will install it, then run :TSUpdate",
						vim.log.levels.WARN
					)
				end)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
				callback = function(args)
					local ok = pcall(vim.treesitter.start, args.buf)
					if ok then
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
