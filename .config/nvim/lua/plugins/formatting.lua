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
					cmake = { "cmakelang" },
					lua = { "stylua" },

					-- webdev
					html = { "prettierd" },
					scss = { "prettierd" },
					css = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },

					--note taking
					markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },

					-- LaTeX
					tex = { "latexindent" },

					-- config
					zsh = { "beautysh" },
					bash = { "beautysh" },
					sh = { "beautysh" },
				},
				format_on_save = { timeout_ms = 500, async = false, lsp_fallback = true },
			})
		end,
	},
}
