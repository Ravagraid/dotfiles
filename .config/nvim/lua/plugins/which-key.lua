return {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		config = function()
			local wk = require('which-key')
			wk.setup({
				plugins = { spelling = true },
				replace = { ['<leader>'] = 'SPC' },
			})
			wk.add({
				mode = { 'n', 'v' },
				{ 'g', group = '+goto' },
				{ ']', group = '+next' },
				{ '[', group = '+prev' },
				{ '<leader>b', group = '+buffer' },
				{ '<leader>c', group = '+code' },
				{ '<leader>f', group = '+file' },
				{ '<leader>g', group = '+git' },
				{ '<leader>s', group = '+search' },
				{ '<leader>u', group = '+ui' },
				{ '<leader>w', group = '+windows' },
				{ '<leader>x', group = '+diagnostics/quickfix' },
				{ '<leader><tab>', group = '+tabs' },
			})
		end,
	},
}
