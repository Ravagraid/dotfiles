local fn = vim.fn
local api = vim.api

api.nvim_create_autocmd(
	{ 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged' },
	{
		group = vim.api.nvim_create_augroup('lint', { clear = true }),
		callback = function() require('lint').try_lint() end,
	}
)
