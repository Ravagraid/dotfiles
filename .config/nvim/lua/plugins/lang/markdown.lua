return {
	{
		"skwee357/nvim-prose",
		lazy = true,
		config = function()
			require("nvim-prose").setup({
				wpm = 200.0,
				filetypes = { "markdown", "asciidoc", "txt" },
				placeholders = {
					words = "words",
					minutes = "min",
				},
			})
		end,
	},
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				app = "browser",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			render_modes = true,
		},
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			legacy_commands = false,
			templates = {
				folder = "Templates",
			},

			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},

			preferred_link_style = "wiki",

			picker = {
				name = "telescope.nvim",
				note_mappings = {
					new = "<C-x>",
					insert_link = "<C-l>",
				},
				tag_mappings = {
					tag_note = "<C-x>",
					insert_tag = "<C-l>",
				},
			},
		},
	},
}
