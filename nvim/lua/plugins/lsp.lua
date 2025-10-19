return {
	{
		"williamboman/mason-lspconfig.nvim",
		version = "1.*",
	},
	{
		"nvimdev/lspsaga.nvim",
		code_action = "",
		code_action_prompt = { enable = false },
		config = function()
			require("lspsaga").setup({
				code_action_prompt = { enable = false },
				lightbulb = { enable = false },
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"mlaursen/vim-react-snippets",
		},
		config = function()
			local lsp = require("lsp-zero")
			local lspConfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lsp.preset("recommended")
			require("mason").setup()
			require("vim-react-snippets").lazy_load()

			local config = require("vim-react-snippets.config")
			config.readonly_props = false

			require("mason-lspconfig").setup({
				ensure_installed = {},
			})

			lsp.ensure_installed({})

			-- Astro setup
			lspConfig.astro.setup({
				capabilities = capabilities,
			})

			-- Lua setup (fixes "undefined global vim")
			lspConfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			-- CMP mappings
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local cmp_mappings = lsp.defaults.cmp_mappings({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			})

			local isLspDiagnosticsVisible = true
			vim.keymap.set("n", "<leader>lx", function()
				isLspDiagnosticsVisible = not isLspDiagnosticsVisible
				vim.diagnostic.config({
					virtual_text = isLspDiagnosticsVisible,
					underline = isLspDiagnosticsVisible,
				})
			end)

			lsp.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = {
					error = "E",
				},
			})

			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }
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
			end)

			lsp.setup()

			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},
}

-- return {
-- 	{
--
-- 		"williamboman/mason-lspconfig.nvim",
-- 		version = "1.*",
-- 	},
-- 	{
-- 		"nvimdev/lspsaga.nvim",
-- 		code_action = "",
--
-- 		code_action_prompt = { enable = false },
-- 		config = function()
-- 			require("lspsaga").setup({
-- 				code_action_prompt = { enable = false },
-- 				lightbulb = {
-- 					enable = false,
-- 				},
-- 			})
-- 		end,
-- 		dependencies = {
-- 			"nvim-treesitter/nvim-treesitter", -- optional
-- 			"nvim-tree/nvim-web-devicons", -- optional
-- 		},
-- 	},
-- 	{
-- 		"VonHeikemen/lsp-zero.nvim",
-- 		branch = "v1.x",
-- 		dependencies = {
-- 			-- LSP Support
-- 			"neovim/nvim-lspconfig",
-- 			"williamboman/mason.nvim",
-- 			-- "Autocompletion"
-- 			"hrsh7th/nvim-cmp",
-- 			"hrsh7th/cmp-buffer",
-- 			"hrsh7th/cmp-path",
-- 			"saadparwaiz1/cmp_luasnip",
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			"hrsh7th/cmp-nvim-lua",
-- 			-- Snippets
-- 			"L3MON4D3/LuaSnip",
-- 			"rafamadriz/friendly-snippets",
-- 			"mlaursen/vim-react-snippets",
-- 		},
-- 		config = function()
-- 			local lsp = require("lsp-zero")
-- 			local lspConfig = require("lspconfig")
-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- 			lsp.preset("recommended")
-- 			require("mason").setup()
--
-- 			require("vim-react-snippets").lazy_load()
--
-- 			local config = require("vim-react-snippets.config")
-- 			config.readonly_props = false
-- 			require("mason-lspconfig").setup({
-- 				-- ensure_installed = {
-- 				-- },
-- 			})
-- 			lsp.ensure_installed({})
--
-- 			lspConfig.astro.setup({
-- 				capabilities = capabilities,
-- 			})
--
-- 			lspConfig.lua_ls.setup({
-- 				-- where should i paste this code bro
-- 				settings = {
-- 					Lua = {
-- 						runtime = {
-- 							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- 							version = "LuaJIT",
-- 							path = vim.split(package.path, ";"),
-- 						},
-- 						diagnostics = {
-- 							-- Get the language server to recognize the `vim` global
-- 							globals = { "vim" },
-- 						},
-- 						workspace = {
-- 							-- Make the server aware of Neovim runtime files and plugins
-- 							library = { vim.env.VIMRUNTIME },
-- 							checkThirdParty = false,
-- 						},
-- 					},
-- 					-- opts = {
-- 					--     servers = {
-- 					--       lua_ls = {
-- 					--         settings = {
-- 					--           Lua = {
-- 					--             diagnostics = {
-- 					--               globals = { "vim" },
-- 					--             },
-- 					--             workspace = {
-- 					--               library = vim.api.nvim_get_runtime_file("", true),
-- 					--               checkThirdParty = false,
-- 					--             },
-- 					--           },
-- 					--         },
-- 					--       },
-- 					--     },
-- 					--   },
-- 					--
-- 				},
-- 				capabilities = capabilities,
-- 				-- other settings
-- 			})
--
-- 			-- Fix Undefined global 'vim'
-- 			-- lsp.configure("lua-language-server", {
-- 			-- 	settings = {
-- 			-- 		Lua = {
-- 			-- 			diagnostics = {
-- 			-- 				globals = { "vim" },
-- 			-- 			},
-- 			-- 		},
-- 			-- 	},
-- 			-- })
--
-- 			local cmp = require("cmp")
-- 			local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- 			local cmp_mappings = lsp.defaults.cmp_mappings({
-- 				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- 				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 				["<C-Space>"] = cmp.mapping.complete(),
-- 			})
-- 			local isLspDiagnosticsVisible = true
-- 			vim.keymap.set("n", "<leader>lx", function()
-- 				isLspDiagnosticsVisible = not isLspDiagnosticsVisible
-- 				vim.diagnostic.config({
-- 					virtual_text = isLspDiagnosticsVisible,
-- 					underline = isLspDiagnosticsVisible,
-- 				})
-- 			end)
-- 			lsp.set_preferences({
-- 				suggest_lsp_servers = false,
-- 				sign_icons = {
-- 					error = "E",
-- 				},
-- 			})
--
-- 			lsp.on_attach(function(client, bufnr)
-- 				local opts = { buffer = bufnr, remap = false }
-- 				vim.keymap.set("n", "gd", function()
-- 					vim.lsp.buf.definition()
-- 				end, opts)
-- 				vim.keymap.set("n", "K", function()
-- 					vim.lsp.buf.hover()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>vws", function()
-- 					vim.lsp.buf.workspace_symbol()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>vd", function()
-- 					vim.diagnostic.open_float()
-- 				end, opts)
-- 				vim.keymap.set("n", "[d", function()
-- 					vim.diagnostic.goto_next()
-- 				end, opts)
-- 				vim.keymap.set("n", "]d", function()
-- 					vim.diagnostic.goto_prev()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>vca", function()
-- 					vim.lsp.buf.code_action()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>vrr", function()
-- 					vim.lsp.buf.references()
-- 				end, opts)
-- 				vim.keymap.set("n", "<leader>vrn", function()
-- 					vim.lsp.buf.rename()
-- 				end, opts)
-- 				vim.keymap.set("i", "<C-h>", function()
-- 					vim.lsp.buf.signature_help()
-- 				end, opts)
-- 			end)
--
-- 			lsp.setup()
--
-- 			vim.diagnostic.config({
-- 				virtual_text = true,
-- 			})
-- 		end,
-- 	},
-- }
