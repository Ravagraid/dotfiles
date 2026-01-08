local function wordcount() return tostring(vim.fn.wordcount().words) .. 'words' end
local function readingtime()
	return tostring(math.ceil(vim.fn.wordcount().words / 200.0)) .. ' min'
end
local function is_markdown()
	return vim.bo.filetype == 'markdown' or vim.bo.filetype == 'asciidoc'
end

return {
	{
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
	},

	{
		'folke/noice.nvim',
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		},
		opts = {
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = false,
			},
			messages = {
				enabled = false,
			},
		},
	},
	{
		'mrjones2014/legendary.nvim',
		dependencies = {
			'folke/snacks.nvim',
		},
		keys = {
			{ '<c-l>', '<cmd>Legendary<cr>', desc = 'Legendary' },
		},
		priority = 10000,
		lazy = false,
		init = function()
			require('legendary').setup({ extensions = { lazy_nvim = true } })
		end,
	},
	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{ 'tpope/vim-dadbod', lazy = true },
			{
				'kristijanhusak/vim-dadbod-completion',
				ft = { 'sql', 'mysql', 'plsql' },
				lazy = true,
			},
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{ 'nvim-tree/nvim-web-devicons', opts = {} },
}
