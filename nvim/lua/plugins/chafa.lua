return {
	"princejoogie/chafa.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		"m00qek/baleia.nvim",
	},
	config = function()
		local chafa = require("chafa")

		chafa.setup({
			render = {
				min_padding = 5,
				show_label = true,
			},
			events = {
				update_on_nvim_resize = true,
			},
		})

		-- here ??
	end,
}
