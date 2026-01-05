return {
	'mason-org/mason-lspconfig.nvim',
	opts = {
		ensure_installed = {
			'jsonls',
			'lua_ls',
			'markdown_oxide',
			'stylua',
			'tinymist',
		},
	},
	dependencies = {
		'mason-org/mason.nvim',
		opts = {
			ui = {
				icons = {
					package_installed = '✓',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
			},
		},
	},
}
