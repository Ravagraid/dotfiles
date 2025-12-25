return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {
			c = { "cpplint" },
		}

		vim.api.nvim_create_autocmd(
			{ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
			{
				group = vim.api.nvim_create_augroup("lint", { clear = true }),
				callback = function() require("lint").try_lint() end,
			}
		)
	end,
}
