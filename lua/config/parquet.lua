local M = {}

local DEFAULT_LIMIT = 200

local function notify(message, level)
	vim.notify(message, level or vim.log.levels.INFO, { title = "Parquet" })
end

local function sql_string(value)
	return "'" .. value:gsub("'", "''") .. "'"
end

local function parse_args(args)
	args = vim.trim(args or "")

	local path = args
	local limit = DEFAULT_LIMIT
	local maybe_path, maybe_limit = args:match("^(.-)%s+(%d+)$")

	if maybe_limit then
		path = vim.trim(maybe_path)
		limit = tonumber(maybe_limit) or DEFAULT_LIMIT
	end

	if path == "" then
		path = vim.api.nvim_buf_get_name(0)
	end

	path = vim.fn.fnamemodify(vim.fn.expand(path), ":p")
	limit = math.max(1, math.floor(limit))

	return path, limit
end

local function open_preview(path, limit, lines)
	vim.cmd("tabnew")
	local bufnr = vim.api.nvim_get_current_buf()
	local name = string.format("parquet://%s?limit=%d", vim.fn.fnamemodify(path, ":t"), limit)

	vim.bo[bufnr].buftype = "nofile"
	vim.bo[bufnr].bufhidden = "wipe"
	vim.bo[bufnr].buflisted = false
	vim.bo[bufnr].swapfile = false
	vim.api.nvim_buf_set_name(bufnr, name)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	vim.bo[bufnr].filetype = "csv"
	vim.bo[bufnr].modifiable = false
	vim.bo[bufnr].readonly = true
end

function M.view(args)
	local duckdb = vim.fn.exepath("duckdb")
	if duckdb == "" then
		notify("duckdb is required for :ParquetView", vim.log.levels.ERROR)
		return
	end

	local path, limit = parse_args(args)
	if path == "" or vim.fn.filereadable(path) ~= 1 then
		notify("Parquet file not found: " .. path, vim.log.levels.ERROR)
		return
	end

	local sql = string.format("select * from read_parquet(%s) limit %d;", sql_string(path), limit)
	local result = vim.system({ duckdb, "-csv", "-header", "-c", sql }, { text = true }):wait()

	if result.code ~= 0 then
		notify(vim.trim(result.stderr), vim.log.levels.ERROR)
		return
	end

	local output = vim.trim(result.stdout)
	if output == "" then
		output = "No rows returned"
	end

	open_preview(path, limit, vim.split(output, "\n", { plain = true }))
end

vim.api.nvim_create_user_command("ParquetView", function(opts)
	M.view(opts.args)
end, {
	nargs = "*",
	complete = "file",
	desc = "Preview a Parquet file with duckdb",
})

return M
