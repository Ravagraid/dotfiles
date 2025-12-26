local key = vim.keymap

-- better up/down
key.set('n', 'j', 'gj')
key.set('n', 'k', 'gk')

-- windows
key.set('n', '<leader>ww', '<C-W>p', { desc = 'other window' })
key.set('n', '<leader>wd', '<C-W>c', { desc = 'delete window' })
key.set('n', '<leader>w-', '<C-W>s', { desc = 'split window below' })
key.set('n', '<leader>w|', '<C-W>v', { desc = 'split window right' })

--Misc QOL maps
key.set('n', '<c-a>', 'ggVG', { desc = 'Select all' })
key.set('n', '<Leader><space>', ':nohl<CR>', { desc = 'Clear search ' })
key.set({ 'i', 'v', 'n', 's' }, '<C-s>', ':w<CR><esc>', { desc = 'Save' })
key.set('n', '<leader>qq', ':qa<CR>', { desc = 'quit' })

--Lazy and plugin maps
key.set('n', '<leader>l', ':Lazy<CR>', { desc = 'Lazy UI' })
