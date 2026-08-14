local key = vim.keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- better up/down
key.set(
	'n',
	'j',
	function() return vim.v.count == 0 and 'gj' or 'j' end,
	{ expr = true, silent = true, desc = 'Down (wrap-aware)' }
)

key.set(
	'n',
	'k',
	function() return vim.v.count == 0 and 'gk' or 'k' end,
	{ expr = true, silent = true, desc = 'Up (wrap-aware)' }
)

key.set('n', '<Leader><space>', ':nohl<CR>', { desc = 'Clear search' })
key.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
key.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

key.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down' })
key.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up' })

key.set('x', '<leader>p', '"_dP"', { desc = 'Paste without yanking' })
key.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without yanking' })

key.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
key.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
key.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
key.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

key.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split window vertically' })
key.set('n', '<leader>sh', ':split<CR>', { desc = 'Split window horizontally' })
key.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
key.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
key.set(
	'n',
	'<C-Left>',
	':vertical resize -2<CR>',
	{ desc = 'Decrease window width' }
)
key.set(
	'n',
	'<C-Right>',
	':vertical resize +2<CR>',
	{ desc = 'Increase window width' }
)

key.set('n', '<c-a>', 'ggVG', { desc = 'Select all' })
key.set({ 'i', 'v', 'n', 's' }, '<C-s>', ':w<CR><esc>', { desc = 'Save' })
key.set('n', '<leader>qq', ':qa<CR>', { desc = 'quit' })
key.set('n', '<leader>qw', ':q!<CR>', { desc = 'quit w/o save' })

key.set('n', '<leader>l', ':Lazy<CR>', { desc = 'Lazy UI' })
key.set(
	'n',
	'<leader>fe',
	':lua MiniFiles.open()<CR>',
	{ desc = 'file explorer' }
)
