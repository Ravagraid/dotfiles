return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "ConformInfo" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					-- programming
					c = { "clang-format" },
					lua = { "stylua" },

					--note taking
					markdown = { "mdformat" },

					-- config
					zsh = { "beautysh" },
					bash = { "beautysh" },
					sh = { "beautysh" },
				},
				format_on_save = {
					timeout_ms = 500,
					async = false,
					lsp_fallback = true,
				},
			})
		end,
	},
}
