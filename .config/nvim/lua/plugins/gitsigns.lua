return {
	'lewis6991/gitsigns.nvim',
	opts = {
		signs = {
			add = { text = '▎' },
			change = { text = '▎' },
			delete = { text = '' },
			topdelete = { text = '' },
			changedelete = { text = '▎' },
			untracked = { text = '▎' },
		},
		signcolumn = true,
		attach_to_untracked = true,
		current_line_blame = true,
	},
}
