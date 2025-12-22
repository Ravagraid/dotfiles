return {
	--Toggler
	{
		"rmagatti/alternate-toggler",
		keys = { { "<leader>i", "<cmd>ToggleAlternate<cr>", desc = "Toggle alternate variable" } },
	},
	{ "gbprod/yanky.nvim", opts = {} },
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},

		cmd = { "TodoTrouble", "TodoTelescope" },
		opts = {},
		keys = {
			{
				"]t",
				function() require("todo-comments").jump_next() end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function() require("todo-comments").jump_prev() end,
				desc = "Previous todo comment",
			},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
	},
	{
		"abecodes/tabout.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>",
				backwards_tabkey = "<S-Tab>",
				act_as_tab = true,
				act_as_shift_tab = false,
				default_tab = "<C-t>",
				default_shift_tab = "<C-d>",
				enable_backwards = true,
				completion = true,
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },

					{ open = "*", close = "*" },
					{ open = "|", close = "|" },
				},
				ignore_beginning = true,
				exclude = {},
			})
		end,
	},
}
