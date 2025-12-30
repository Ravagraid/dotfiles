return {
	'rmagatti/alternate-toggler',
	keys = {
		{
			'<leader>i',
			'<cmd>ToggleAlternate<cr>',
		},
	},
	opts = { alternates = { ['=='] = '!=' } },
}
