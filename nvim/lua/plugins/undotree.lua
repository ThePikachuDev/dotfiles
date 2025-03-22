return {
    'mbbill/undotree',
    configs = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end

}
