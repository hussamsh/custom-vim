local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("n", "<leader><space>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>b", "<C-^>", { desc = "Alternate buffer" })

map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map({ "n", "v" }, "<leader>s", "^", { desc = "Start of line text" })
map({ "n", "v" }, "<leader>d", "$", { desc = "End of line" })
map("n", "<leader>re", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace word under cursor" })
map("i", "<leader>m", "<C-o>A;", { desc = "Append semicolon" })

map("v", "<leader>cpa", '"ay', { desc = "Copy selection to register a" })
map("n", "<leader>cpwa", '"ayiw', { desc = "Copy word to register a" })
map("n", "<leader>cpla", '"ayy', { desc = "Copy line to register a" })
map("n", "<leader>pa", '"ap', { desc = "Paste register a" })

map("v", "<leader>cpb", '"by', { desc = "Copy selection to register b" })
map("n", "<leader>cpwb", '"byiw', { desc = "Copy word to register b" })
map("n", "<leader>cplb", '"byy', { desc = "Copy line to register b" })
map("n", "<leader>pb", '"bp', { desc = "Paste register b" })

map("v", "<leader>cp+", '"+y', { desc = "Copy selection to system clipboard" })
map("n", "<leader>cpw+", '"+yiw', { desc = "Copy word to system clipboard" })
map("n", "<leader>cpl+", '"+yy', { desc = "Copy line to system clipboard" })
map("n", "<leader>p+", '"+p', { desc = "Paste system clipboard" })

map("n", "<leader>ev", "<cmd>tabedit $MYVIMRC<cr>", { desc = "Edit Neovim config" })
map("n", "<leader>epl", "<cmd>vsplit ~/.config/nvim/lua/plugins<cr>", { desc = "Edit plugin specs" })
map("n", "<leader>ecs", "<cmd>vsplit ~/.config/nvim/lua/config<cr>", { desc = "Edit core config" })
