return {
	'rmagatti/alternate-toggler',
	keys = {
		{
			'<leader>i',
			'<cmd>ToggleAlternate<cr>',
			desc = 'Toggle',
		},
	},
	opts = { alternates = { ['=='] = '!=' } },
}
