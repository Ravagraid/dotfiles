return {
	{
		'sainnhe/everforest',
		priority = 1000,
		config = function() vim.cmd.colorscheme('everforest') end,
	},
	{
		'catgoose/nvim-colorizer.lua',
		event = 'BufReadPre',
		config = function()
			require('colorizer').setup({
				user_default_options = { names = false },
			})
		end,
	},
}
