local function wordcount() return tostring(vim.fn.wordcount().words) .. 'words' end
local function readingtime()
	return tostring(math.ceil(vim.fn.wordcount().words / 200.0)) .. ' min'
end
local function is_markdown()
	return vim.bo.filetype == 'markdown' or vim.bo.filetype == 'asciidoc'
end

return {
	'nvim-lualine/lualine.nvim',
	opts = {
		options = {
			component_separators = '',
			section_separators = { left = '', right = '' },
		},
		sections = {
			lualine_a = { 'mode', 'branch' },
			lualine_b = {
				{ 'filename', path = 1 },
				{ 'filesize' },
				{ wordcount, cond = is_markdown },
				{ readingtime, cond = is_markdown },
			},
			lualine_c = { 'diagnostics', 'diff' },
			lualine_x = { 'encoding', 'fileformat' },
			lualine_y = { 'location', 'progress' },
			lualine_z = { 'filetype' },
		},
	},
}
