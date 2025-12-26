return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		cmd = 'Neotree',
		keys = {
			{
				'<leader>fe',
				function()
					require('neo-tree.command').execute({ toggle = true })
				end,
				desc = 'Explorer NeoTree (Root Dir)',
			},
			{
				'<leader>fE',
				function()
					require('neo-tree.command').execute({
						toggle = true,
						dir = vim.uv.cwd(),
					})
				end,
				desc = 'Explorer NeoTree (cwd)',
			},
		},
		init = function()
			vim.api.nvim_create_autocmd('BufEnter', {
				group = vim.api.nvim_create_augroup(
					'Neotree_start_directory',
					{ clear = true }
				),
				desc = 'Start Neo-tree with directory',
				once = true,
				callback = function()
					if package.loaded['neo-tree'] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == 'directory' then
							require('neo-tree')
						end
					end
				end,
			})
		end,
		opts = {
			sources = { 'filesystem', 'buffers' },
			open_files_do_not_replace_types = {
				'terminal',
				'Trouble',
				'trouble',
				'qf',
				'Outline',
			},
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				width = 30,
				mappings = {
					['l'] = 'open',
					['h'] = 'close_node',
					['<space>'] = 'none',
					['O'] = {
						function(state)
							require('lazy.util').open(
								state.tree:get_node().path,
								{ system = true }
							)
						end,
						desc = 'Open with System Application',
					},
					['P'] = { 'toggle_preview', config = { use_float = false } },
				},
			},
		},
	},
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
	{
		'RRethy/vim-illuminate',
		event = 'VeryLazy',
		opts = {
			delay = 100,
			large_file_cutoff = 2000,
			large_file_overrides = { providers = { 'lsp' } },
		},
		config = function(_, opts)
			require('illuminate').configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set(
					'n',
					key,
					function()
						require('illuminate')['goto_' .. dir .. '_reference'](
							false
						)
					end,
					{
						desc = dir:sub(1, 1):upper()
							.. dir:sub(2)
							.. ' Reference',
						buffer = buffer,
					}
				)
			end

			vim.api.nvim_create_autocmd('FileType', {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map(']]', 'next', buffer)
					map('[[', 'prev', buffer)
				end,
			})
		end,
		keys = {
			{ ']]', desc = 'Next Reference' },
			{ '[[', desc = 'Prev Reference' },
		},
	},

	{ 'mg979/vim-visual-multi' },
}
