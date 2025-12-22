return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"diff",
					"json",
					"json5",
					"jsonc",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"regex",
					"vimdoc",
					"vim",
				},

				sync_install = false,
				auto_install = true,

				highlight = { enable = true, additional_vim_regex_highlighting = false },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
			})
			require("nvim-treesitter.install").prefer_git = false
			require("nvim-treesitter.install").compilers = { "clang" }
		end,
	},
}
