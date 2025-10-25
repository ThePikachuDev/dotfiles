local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "failed to clone lazy.nvim:\n", "errormsg" },
			{ out, "warningmsg" },
			{ "\npress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.opt.nu = true
vim.opt.relativenumber = true

-- this will set tabs to 4 spaces instead of 8 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "0"

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.colorcolumn = ""
	end,
})

vim.filetype.add({
	extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
	filename = {
		["vifmrc"] = "vim",
	},
	pattern = {
		[".*/waybar/config"] = "jsonc",
		[".*/mako/config"] = "dosini",
		[".*/kitty/.+%.conf"] = "kitty",
		[".*/hypr/.+%.conf"] = "hyprlang",
		["%.env%.[%w_.-]+"] = "sh",
	},
})
vim.treesitter.language.register("bash", "kitty")

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
		-- { import = "plugins.lsp" },
	},
	install = { colorscheme = { "habamax" } },
	-- checker = { enabled = true, notify = false },
})

--
-- vim.lsp.config({
-- 	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
-- 	cmd = { "typescript-language-server", "--stdio" },
-- })

-- vim.lsp.config("lua_ls", {})
-- vim.lsp.config("ts_ls", {
-- 	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
-- 	cmd = { "typescript-language-server", "--stdio" },
-- })

-- require("lspconfig").lua_ls.setup({})

-- require("lspconfig").ts_ls.setup({
-- 	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
-- 	cmd = { "typescript-language-server", "--stdio" },
-- })

-- require("nvim-ts-autotag").setup({
-- 	opts = {
-- 		enable_close = true,
-- 		enable_rename = true,
-- 		enable_close_on_slash = false,
-- 	},
-- 	per_filetype = {
-- 		["html"] = {
-- 			enable_close = false,
-- 		},
-- 	},
-- })
--
-- require("lspconfig").zls.setup({})
-- require("lspconfig").qmlls.setup {
--     cmd = { "qmlls", "-E" }
-- }

--
-- -- 🔰 Keyword Highlights: TODO / NOTME / DOING / DONE
--
-- -- Define highlight groups with nice, modern colors
-- vim.api.nvim_set_hl(0, "TodoHighlight", { fg = "#ffcc00", bold = true }) -- Yellow
-- vim.api.nvim_set_hl(0, "NotMeHighlight", { fg = "#c678dd", bold = true }) -- Purple
-- vim.api.nvim_set_hl(0, "DoingHighlight", { fg = "#61afef", bold = true }) -- Blue
-- vim.api.nvim_set_hl(0, "DoneHighlight", { fg = "#98c379", bold = true }) -- Green
--
-- -- Apply them whenever a buffer is opened
-- vim.cmd([[
--   augroup highlight_keywords
--     autocmd!
--     autocmd BufEnter,BufWinEnter * call matchadd('TodoHighlight', '\<TODO\>')
--     autocmd BufEnter,BufWinEnter * call matchadd('NotMeHighlight', '\<NOTME\>')
--     autocmd BufEnter,BufWinEnter * call matchadd('DoingHighlight', '\<DOING\>')
--     autocmd BufEnter,BufWinEnter * call matchadd('DoneHighlight', '\<DONE\>')
--   augroup END
-- ]])
