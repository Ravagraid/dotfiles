return {
	'obsidian-nvim/obsidian.nvim',
	version = '*', -- use latest release, remove to use latest commit
	ft = 'markdown',
	opts = {
		legacy_commands = false, -- this will be removed in the next major release
		workspaces = {
			{
				name = 'personal',
				path = '~/Notes/',
			},
		},
	},
}
