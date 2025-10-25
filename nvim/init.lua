require("config.lazy")
require("config.remap")

-- Configure LSP clients

-- Set default root markers for all clients
vim.lsp.config("*", {
	root_markers = { ".git" },
})

-- Set configuration for typescript language server
vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

-- Enable Typescript Language Server
vim.lsp.enable("ts_ls")
