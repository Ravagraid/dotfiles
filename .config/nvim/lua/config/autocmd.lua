local api = vim.api
local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- highlight on yank
api.nvim_create_autocmd('TextYankPost', {
	group = augroup,
	callback = function() vim.hl.on_yank() end,
})

-- return to last cursor position
api.nvim_create_autocmd('BufReadPost', {
	group = augroup,
	desc = 'Restore last cursor position',
	callback = function()
		if vim.o.diff then return end
		local last_pos = api.nvim_buf_get_mark(0, '"')
		local last_line = api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then return end

		pcall(api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak, spellcheck on markdown and text files
api.nvim_create_autocmd('FileType', {
	group = augroup,
	pattern = { 'markdown', 'text', 'gitcommit' },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})
