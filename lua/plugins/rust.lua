return {
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				tools = {
					test_executor = "neotest",
				},
				server = {
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							check = {
								command = "clippy",
							},
							inlayHints = {
								lifetimeElisionHints = {
									enable = "skip_trivial",
								},
							},
						},
					},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("rust_keymaps", { clear = true }),
				pattern = "rust",
				callback = function(event)
					local function map(lhs, rhs, desc)
						vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
					end

					map("<leader>ra", function()
						vim.cmd.RustLsp("codeAction")
					end, "Rust code action")
					map("<leader>rh", function()
						vim.cmd.RustLsp({ "hover", "actions" })
					end, "Rust hover actions")
					map("<leader>rr", function()
						vim.cmd.RustLsp("runnables")
					end, "Rust runnables")
					map("<leader>rt", function()
						vim.cmd.RustLsp("testables")
					end, "Rust testables")
					map("<leader>rd", function()
						vim.cmd.RustLsp("debuggables")
					end, "Rust debuggables")
					map("<leader>rm", function()
						vim.cmd.RustLsp("expandMacro")
					end, "Rust expand macro")
				end,
			})
		end,
	},
}
