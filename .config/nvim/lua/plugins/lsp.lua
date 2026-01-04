return {
	{
		'mason-org/mason-lspconfig.nvim',
		lazy = false,
		dependencies = {
			{
				'mason-org/mason.nvim',
				opts = {
					ui = {
						icons = {
							package_installed = '✓',
							package_pending = '➜',
							package_uninstalled = '✗',
						},
					},
				},
			},
		},
		opts = {},
	},
	{
		'nvimdev/lspsaga.nvim',
		lazy = false,
		keys = {
			--code
			{
				'<leader>ca',
				'<cmd>Lspsaga code_action<cr>',
				desc = 'code action',
			},
			{
				'<leader>ch',
				'<cmd>Lspsaga hover_doc<cr>',
				desc = 'hover diagnostics',
			},
			{ '<leader>co', '<cmd>Lspsaga outline<cr>', desc = 'code outline' },
			{ '<leader>cr', '<cmd>Lspsaga rename<cr>', 'code rename' },

			--next/prev
			{
				']d',
				'<cmd>Lspsaga diagnostic_jump_next<cr>',
				desc = 'next diagnostic',
			},
			{
				'[d',
				'<cmd>Lspsaga diagnostic_jump_prev<cr>',
				desc = 'previous diagnostic',
			},

			--goto
			{
				'gd',
				'<cmd>Lspsaga goto_definition<cr>',
				desc = 'goto defintion',
			},
		},
		config = function()
			require('lspsaga').setup({
				diagnostic = {
					border_follow = false,
				},
				symbol_in_winbar = {
					show_file = false,
					delay = 0,
				},
				ui = {
					border = 'rounded',
					code_action = '',
				},
			})
			vim.keymap.set(
				'n',
				'<space>k',
				'<cmd>Lspsaga hover_doc<cr>',
				{ silent = true }
			)
		end,
	},
}
