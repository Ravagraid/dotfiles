return {
	'mason-org/mason-lspconfig.nvim',
	opts = {
		ensure_installed = {
			'beautysh',
			'clang-format',
			'jsonls',
			'lua_ls',
			'markdown_oxide',
			'mdformat',
			'prettypst',
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
