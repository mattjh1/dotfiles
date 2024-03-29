vim.opt.clipboard = "unnamed"
vim.opt.cul = false
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.fillchars = { eob = " " }
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.timeoutlen = 400
vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.conceallevel = 1

vim.opt.laststatus = 3
vim.opt.statusline = " "
vim.opt.cmdheight = 1
vim.opt.lazyredraw = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.bo.softtabstop = 2
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.colorcolumn = "90"

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.cmd("set foldcolumn=0")
vim.cmd("set foldenable")
vim.cmd("set foldlevel=99")
vim.cmd("set foldmethod=indent")
vim.cmd("set foldnestmax=1")
vim.opt.termguicolors = true
