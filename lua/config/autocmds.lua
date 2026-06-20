local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function ensure_parent_dir_exists(args)
	local filename = args.file
	if filename == "" then
		return
	end

	local parent = vim.fs.dirname(vim.fs.normalize(filename))
	if not parent or parent == "." then
		return
	end

	if vim.fn.isdirectory(parent) == 0 then
		vim.fn.mkdir(parent, "p")
	end
end

autocmd("TextYankPost", {
	group = augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 180 })
	end,
})

autocmd("BufReadPost", {
	group = augroup("restore_cursor", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

autocmd("FileType", {
	group = augroup("local_format_options", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

autocmd({ "BufNewFile", "BufWritePre" }, {
	group = augroup("create_parent_dirs", { clear = true }),
	callback = ensure_parent_dir_exists,
})
