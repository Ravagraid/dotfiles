return {
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets' },
		version = '1.*',
		opts = {
			keymap = { preset = 'default' },
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			fuzzy = { implementation = 'prefer_rust_with_warning' },
		},
		opts_extend = { 'sources.default' },
	},
	{
		'folke/todo-comments.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
		},

		cmd = { 'TodoTrouble', 'TodoTelescope' },
		opts = {},
		keys = {
			{
				']t',
				function() require('todo-comments').jump_next() end,
				desc = 'Next todo comment',
			},
			{
				'[t',
				function() require('todo-comments').jump_prev() end,
				desc = 'Previous todo comment',
			},
			{ '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo (Trouble)' },
			{
				'<leader>xT',
				'<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>',
				desc = 'Todo/Fix/Fixme (Trouble)',
			},
			{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
			{
				'<leader>sT',
				'<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>',
				desc = 'Todo/Fix/Fixme',
			},
		},
	},
}
