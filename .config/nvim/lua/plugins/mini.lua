return {
	'nvim-mini/mini.nvim',
	version = '*',
	config = function()
		local miniclue = require('mini.clue')
		-- Text editing
		require('mini.comment').setup()
		require('mini.move').setup()
		require('mini.pairs').setup({
			mappings = {
				['*'] = {
					action = 'closeopen',
					pair = '**',
					neigh_pattern = '[^\\].',
					register = { cr = false },
				},
			},
		})
		require('mini.surround').setup()

		-- General workflow
		require('mini.basics').setup()
		miniclue.setup({
			triggers = {
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'x', keys = '<Leader>' },

				-- mini.basics
				{ mode = 'n', keys = '\\' },

				-- Built-in completion
				{ mode = 'i', keys = '<C-x>' },

				-- `g` key
				{ mode = 'n', keys = 'g' },
				{ mode = 'x', keys = 'g' },

				-- Marks
				{ mode = 'n', keys = "'" },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = "'" },
				{ mode = 'x', keys = '`' },

				-- Registers
				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },

				-- Window commands
				{ mode = 'n', keys = '<C-w>' },

				-- `z` key
				{ mode = 'n', keys = 'z' },
				{ mode = 'x', keys = 'z' },
			},
			clues = {
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),

				{ mode = 'n', keys = '' },
			},
		})
		require('mini.files').setup()
		-- Appearance
		require('mini.animate').setup()
		require('mini.cursorword').setup()
		require('mini.indentscope').setup({
			symbol = '│',
			options = { try_as_border = true },
		})
		require('mini.icons').setup({
			lsp = { -- Icons from lspkind.nvim
				text = { glyph = '󰉿' },
				method = { glyph = '󰆧' },
				['function'] = { glyph = '󰊕' },
				constructor = { glyph = '' },
				field = { glyph = '󰜢' },
				variable = { glyph = '󰀫' },
				class = { glyph = '󰠱' },
				interface = { glyph = '' },
				module = { glyph = '' },
				property = { glyph = '󰜢' },
				unit = { glyph = '󰑭' },
				value = { glyph = '󰎠' },
				enum = { glyph = '' },
				keyword = { glyph = '󰌋' },
				snippet = { glyph = '' },
				color = { glyph = '󰏘' },
				file = { glyph = '󰈙' },
				reference = { glyph = '󰈇' },
				folder = { glyph = '󰉋' },
				enumMember = { glyph = '' },
				constant = { glyph = '󰏿' },
				struct = { glyph = '󰙅' },
				event = { glyph = '' },
				operator = { glyph = '󰆕' },
				typeParameter = { glyph = '' },
			},
		})
	end,
}
