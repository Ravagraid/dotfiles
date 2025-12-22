local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.wrap = true
opt.linebreak = true -- break on words
opt.breakindent = true -- align wrapped line with previous indent level
opt.breakindentopt = "list:-1"

opt.scrolloff = 5
opt.sidescrolloff = 5

opt.hlsearch = true
opt.incsearch = true

opt.mouse = "a"
opt.clipboard:append("unnamedplus")

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true

opt.signcolumn = "yes"
-- opt.list = true

opt.cursorline = true
opt.termguicolors = true
opt.showmode = false

opt.updatetime = 300
opt.timeoutlen = 500

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- opt.conceallevel = 2

-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99

opt.spell = true
opt.spelllang = "en_gb"
