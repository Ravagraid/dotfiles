return {
	{
		'stevearc/conform.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		cmd = { 'ConformInfo' },
		opts = {
			formatters_by_ft = {
				-- programming
				c = { 'clang-format' },
				lua = { 'stylua' },

				--note taking
				markdown = { 'mdformat' },

				-- config
				zsh = { 'beautysh' },
				bash = { 'beautysh' },
				sh = { 'beautysh' },

				-- typesetting
				typst = { 'prettypst' },
			},
			format_on_save = {
				timeout_ms = 500,
				async = false,
				lsp_fallback = true,
			},
		},
	},
}
