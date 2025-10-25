vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree (floating)" })
vim.keymap.set("n", "<leader>pj", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle NvimTree at file" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- this keybind will source your file on pressing <leader><leader ( for me its <space><space> )
vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>")

-- My custom keybinds

vim.keymap.set("n", "<leader>lx", function()
	local current_state = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current_state })
end, { desc = "Toggle LSP diagnostics virtual text" })

function RemoveAllComments()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local bufnr = vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr)
	local tree = parser:parse()[1]
	local root = tree:root()

	local comments = {}
	local function find_comments(node)
		for child in node:iter_children() do
			if child:type():find("comment") then
				table.insert(comments, child)
			else
				find_comments(child)
			end
		end
	end

	find_comments(root)

	for i = #comments, 1, -1 do
		local node = comments[i]
		local start_row, start_col, end_row, end_col = node:range()
		vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, {})
	end
end

-- this keybind will remove all the comments in the current file when you press <leader>rc ( for me its <space>rc )
vim.keymap.set("n", "<leader>rc", RemoveAllComments, { desc = "Remove all comments" })
vim.keymap.set("n", "<leader>tc", "<cmd>SupermavenToggle<CR>", { desc = "Remove all comments" })

vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, opts)
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end, opts)
vim.keymap.set("n", "<leader>vws", function()
	vim.lsp.buf.workspace_symbol()
end, opts)
vim.keymap.set("n", "<leader>vd", function()
	vim.diagnostic.open_float()
end, opts)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next()
end, opts)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev()
end, opts)
vim.keymap.set("n", "<leader>vca", function()
	vim.lsp.buf.code_action()
end, opts)
vim.keymap.set("n", "<leader>vrr", function()
	vim.lsp.buf.references()
end, opts)
vim.keymap.set("n", "<leader>vrn", function()
	vim.lsp.buf.rename()
end, opts)

vim.keymap.set("i", "<C-h>", function()
	vim.lsp.buf.signature_help()
end, opts)
