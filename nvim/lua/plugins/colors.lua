return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd.colorscheme('retrobox')
        end
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... }

}
