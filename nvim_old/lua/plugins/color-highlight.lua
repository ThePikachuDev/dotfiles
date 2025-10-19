return {
	-- "brenoprata10/nvim-highlight-colors",
	"norcalli/nvim-colorizer.lua",
	enabled = true,
	config = function()
		require("colorizer").setup()
	end,
}
