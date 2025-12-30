return {
	{
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
	},
	{
		'folke/trouble.nvim',
		cmd = { 'TroubleToggle', 'Trouble' },
		opts = { use_diagnostic_signs = true },
		keys = {
			--diagnostics
			{
				'<leader>xx',
				'<cmd>Trouble diagnostics toggle<cr>',
				desc = 'Document Diagnostics (Trouble)',
			},
			{
				'<leader>xX',
				'<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
				desc = 'Workspace Diagnostics (Trouble)',
			},
			{
				'<leader>xL',
				'<cmd>Trouble loclist toggle<cr>',
				desc = 'Location List (Trouble)',
			},
			{
				'<leader>xQ',
				'<cmd>Trouble qflist toggle<cr>',
				desc = 'Quickfix List (Trouble)',
			},

			--next/prev
			{
				'[q',
				function()
					if require('trouble').is_open() then
						require('trouble').previous({
							skip_groups = true,
							jump = true,
						})
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then vim.notify(err, vim.log.levels.ERROR) end
					end
				end,
				desc = 'Previous trouble/quickfix item',
			},
			{
				']q',
				function()
					if require('trouble').is_open() then
						require('trouble').next({
							skip_groups = true,
							jump = true,
						})
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then vim.notify(err, vim.log.levels.ERROR) end
					end
				end,
				desc = 'Next trouble/quickfix item',
			},
		},
	},
	{
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
			current_line_blame = true,
		},
		init = function() require('gitsigns').setup() end,
	},
	{ 'mg979/vim-visual-multi' },
}
