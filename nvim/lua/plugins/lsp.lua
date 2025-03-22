return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- "Autocompletion"
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
        config = function()
            local lsp = require("lsp-zero")
            local lspConfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lsp.preset('recommended')
            lsp.ensure_installed({
                'css_variables',
                'eslint',
                'cssls',
                'cssmodules_ls',
                'docker_compose_language_service',
                'dockerls',
                'glsl_analyzer',
                'glslls',
                'golangci_lint_ls',
                'gopls',
                'clangd',
                'html',
                'htmx',
                'lua_ls',
                'ts_ls',
                'astro',
                'pylsp',
            })
            lspConfig.astro.setup{
                capabilities = capabilities,
            }
            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({select = true}),
                ['<C-Space>'] = cmp.mapping.complete(),
            })
            local isLspDiagnosticsVisible = true
            vim.keymap.set("n", "<leader>lx", function()
                isLspDiagnosticsVisible = not isLspDiagnosticsVisible
                vim.diagnostic.config({
                    virtual_text = isLspDiagnosticsVisible,
                    underline = isLspDiagnosticsVisible
                })
            end)
            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                }
            })
            
            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)
            
            lsp.setup()
            
            vim.diagnostic.config({
                virtual_text = true
            })
        end
    }
}
