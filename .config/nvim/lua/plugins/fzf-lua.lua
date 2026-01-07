return {
	'ibhagwan/fzf-lua',
	keys = {
		{
			'<leader>ff',
			"<cmd>lua require('fzf-lua').files()<cr>",
			desc = 'find files',
		},
		{
			'<leader>fg',
			"<cmd>lua require('fzf-lua').live_grep()<cr>",
			desc = 'find text',
		},
	},
}
