local opt = vim.opt

opt.relativenumber = true
opt.wrap = true
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.hlsearch = true

opt.colorcolumn = '80'
opt.showmatch = true
opt.cmdheight = 1
opt.completeopt = 'menuone,noinsert,noselect'
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 0
opt.winborder = 'rounded'
opt.conceallevel = 0
opt.concealcursor = ''
opt.synmaxcol = 300
opt.fillchars = { eob = ' ' }
opt.termguicolors = true

local undodir = vim.fn.expand('~/.vim/undodir')
if vim.fn.isdirectory(undodir) == 0 then vim.fn.mkdir(undodir, 'p') end

opt.swapfile = false
opt.undodir = undodir
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 0
opt.autoread = true
opt.autowrite = false

opt.hidden = true
opt.errorbells = false
opt.backspace = 'indent,eol,start'
opt.autochdir = false
opt.iskeyword:append('-')
opt.path:append('**')
opt.selection = 'inclusive'
opt.clipboard:append('unnamedplus')
opt.modifiable = true
opt.encoding = 'utf-8'

opt.guicursor =
	'n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99

opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.diffopt:append('linematch:60')
opt.redrawtime = 10000
opt.maxmempattern = 20000
