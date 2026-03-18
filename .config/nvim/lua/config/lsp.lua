vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if
			client
			and client:supports_method(
				vim.lsp.protocol.Methods.textDocument_completion
			)
		then
			vim.opt.completeopt =
				{ 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
			vim.lsp.completion.enable(
				true,
				client.id,
				ev.buf,
				{ autotrigger = true }
			)
		end
	end,
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.HINT] = '',
			[vim.diagnostic.severity.INFO] = '',
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
		focusable = false,
		style = 'minimal',
	},
})
