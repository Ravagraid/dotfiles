return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = '1.*',
	opts = {
		keymap = { preset = 'default' },
		completion = {
			menu = {
				draw = {
					columns = {
						{ 'label', 'label_description', gap = 1 },
						{ 'kind_icon', 'kind' },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ =
									require('mini.icons').get('lsp', ctx.kind)
								return kind_icon
							end,
						},
					},
				},
			},
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		fuzzy = {
			implementation = 'prefer_rust',
			prebuilt_binaries = { download = true },
		},
	},
}
