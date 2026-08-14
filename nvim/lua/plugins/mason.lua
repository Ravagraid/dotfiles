return {
	'WhoIsSethDaniel/mason-tool-installer.nvim',
	dependencies = {
		'mason-org/mason.nvim',
		opts = {
			ui = {
				icons = {
					package_installed = '',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
			},
		},
	},
	opts = {
		ensure_installed = {
			'bash-language-server',
			'beautysh',
			'clang-format',
			'clangd',
			'json-lsp',
			'kdlfmt',
			'lua-language-server',
			'markdown-oxide',
			'mdformat',
			'prettier',
			'stylua',
			'systemd-lsp',
			'systemdlint',
			'tinymist',
			'typstyle',
		},
		auto_update = true,
		start_delay = 3000,
	},
}
