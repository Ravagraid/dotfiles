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

				--web dev
				markdown = { 'prettier' },
				javascript = { 'prettier' },
				typescript = { 'prettier' },

				-- config
				zsh = { 'beautysh' },
				bash = { 'beautysh' },
				sh = { 'beautysh' },
				kdl = { 'kdlfmt' },

				-- typesetting
				typst = { 'typstyle' },
			},
			format_on_save = {
				timeout_ms = 500,
				async = false,
				lsp_fallback = true,
			},
		},
	},
}
