return {
	'nvim-telescope/telescope.nvim',
	cmd = 'Telescope',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = {
		{
			'<leader>ff',
			"<cmd>lua require('telescope.builtin').find_files()<cr>",
			desc = 'find files',
		},
		{
			'<leader>fg',
			"<cmd>lua require('telescope.builtin').live_grep()<cr>",
			desc = 'find text',
		},
	},
	config = function()
		local actions = require('telescope.actions')
		require('telescope').setup({
			defaults = {
				mappings = { i = { ['<esc>'] = actions.close } },
				file_ignore_patterns = {
					'node_modules',
					'yarn.lock',
					'.git',
					'lazy-lock.json',
					'%.lock',
				},
				dynamic_preview_title = true,
				path_display = { 'smart' },
			},
			pickers = { find_files = { hidden = true } },
			layout_config = {
				horizontal = {
					preview_cutoff = 100,
					preview_width = 0.6,
				},
			},
		})
	end,
}
