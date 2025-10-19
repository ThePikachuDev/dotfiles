return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd.colorscheme("kanagawa-dragon")

			--            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
	{ "rebelot/kanagawa.nvim" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
}
