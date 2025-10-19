return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			local HEIGHT_RATIO = 0.8
			local WIDTH_RATIO = 0.7

			-- Setup nvim-tree with floating view
			require("nvim-tree").setup({
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = math.floor(window_w),
								height = math.floor(window_h),
							}
						end,
					},
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
				},
				renderer = {
					group_empty = true,
				},
				git = {
					enable = true,
					ignore = false,
					timeout = 500,
				},
				filters = {
					dotfiles = false,
				},
			})

			vim.opt.termguicolors = true
		end,
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },
}
