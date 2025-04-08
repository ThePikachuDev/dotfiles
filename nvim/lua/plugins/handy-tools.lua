return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufReadPost',
    config = function()
        vim.o.foldcolumn = '1' -- Show fold column
        vim.o.foldlevel = 99   -- Needed for ufo
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Keymaps
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })

        -- Setup UFO with treesitter + indent providers
        require('ufo').setup({
            provider_selector = function(_, _, _)
                return { 'treesitter', 'indent' }
            end
        })

        -- LSP capability for folding
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        -- Inject folding capabilities into all LSP servers
        local lspconfig = require('lspconfig')
        for _, server in ipairs(vim.tbl_keys(lspconfig)) do
            local opts = lspconfig[server].document_config and lspconfig[server].document_config.default_config or {}
            opts.capabilities = vim.tbl_deep_extend('force', opts.capabilities or {}, capabilities)
            lspconfig[server].setup(opts)
        end
    end
}
