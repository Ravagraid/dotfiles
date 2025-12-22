return {
	{
		"mason-org/mason.nvim",
		priority = 1000,
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup({
				PATH = "prepend",
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			require("mason-lspconfig").setup({})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"fixjson",
					"json-lsp",
					"lua-language-server",
					"prettier",
					"stylua",
					"vim-language-server",
					"yaml-language-server",
					"yamllint",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			-- c, c++, cmake
			vim.lsp.enable("clangd")
			vim.lsp.enable("cmake")

			-- lua
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			})

			-- markdown
			vim.lsp.enable("marksman")

			--yaml
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})

			--webdev
			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						format = {
							enable = true,
						},
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		lazy = false,
		keys = {
			--code
			{ "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "code action" },
			{ "<leader>ch", "<cmd>Lspsaga hover_doc<cr>", desc = "hover diagnostics" },
			{ "<leader>co", "<cmd>Lspsaga outline<cr>", desc = "code outline" },
			{ "<leader>cr", "<cmd>Lspsaga rename<cr>", "code rename" },

			--next/prev
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "previous diagnostic" },

			--goto
			{ "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "goto defintion" },
		},
		config = function()
			require("lspsaga").setup({
				diagnostic = {
					border_follow = false,
				},
				symbol_in_winbar = {
					show_file = false,
					delay = 0,
				},
				ui = {
					border = "rounded",
					code_action = "",
				},
			})

			vim.keymap.set("n", "<space>k", "<cmd>Lspsaga hover_doc<cr>", { silent = true })

			-- error lens
			vim.fn.sign_define({
				{
					name = "DiagnosticSignError",
					text = "",
					texthl = "DiagnosticSignError",
					linehl = "ErrorLine",
				},
				{
					name = "DiagnosticSignWarn",
					text = "",
					texthl = "DiagnosticSignWarn",
					linehl = "WarningLine",
				},
				{
					name = "DiagnosticSignInfo",
					text = "",
					texthl = "DiagnosticSignInfo",
					linehl = "InfoLine",
				},
				{
					name = "DiagnosticSignHint",
					text = "",
					texthl = "DiagnosticSignHint",
					linehl = "HintLine",
				},
			})
		end,
	},
}
