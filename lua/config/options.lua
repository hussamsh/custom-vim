local opt = vim.opt

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

local nvim_python = vim.fn.stdpath("data") .. "/python"
local nvim_python_bin = nvim_python .. "/bin"
local nvim_python_host = nvim_python_bin .. "/python"
if vim.uv.fs_stat(nvim_python_host) then
	vim.g.python3_host_prog = nvim_python_host
	vim.env.PATH = nvim_python_bin .. ":" .. vim.env.PATH
end

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3
opt.showmode = false
opt.confirm = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 400

opt.completeopt = { "menu", "menuone", "noselect" }

opt.clipboard = "unnamedplus"

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
