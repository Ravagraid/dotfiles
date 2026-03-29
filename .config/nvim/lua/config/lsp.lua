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
	virtual_text = { prefix = '●', spacing = 4 },
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

vim.lsp.config['*'] = {
	capabilities = require('blink.cmp').get_lsp_capabilities(),
}

vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	settings = {
		Lua = {
			completion = { callSnippet = 'Replace' },
			diagnostics = { globals = { 'vim' } },
			runtime = { version = 'LuaJIT' },
		},
	},
})

vim.lsp.config('markdown_oxide', {
	cmd = { 'markdown-oxide' },
	filetypes = { 'markdown' },
	root_markers = { '.git', '.obsidian', '.moxide.toml' },
})

vim.lsp.enable({
	'lua_ls',
	'markdown_oxide',
})
