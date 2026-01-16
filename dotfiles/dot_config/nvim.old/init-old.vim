set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Turn on syntax highlighting

syntax on

let mapleader = ","  

"general keybinds

" Edit the .bashrc"
nmap <silent> <leader>ez :e ~/.zshrc<CR>
" Edit the .vimrc"
nmap <silent> <leader>ev :e ~/.vimrc<CR>
" Edit the .gitconfig"
nmap <silent> <leader>eg :e ~/.gitconfig<CR>
" Edit the .tmux.conf"
nmap <silent> <leader>et :e ~/.tmux.conf<CR>

" insert closing braces
inoremap {<CR> {<CR>}<Esc>ko<tab>
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha
inoremap < <><Esc>ha
" New line up/down without entering insert mode
nmap OO O<Esc>k
nmap oo O<Esc>j
" copy/paste to system clipboard (visual mode)
vnoremap <C-c> "*y
vnoremap <C-v> "*p

" esc in insert & visual mode
inoremap hj <esc>
vnoremap hj <esc>
" esc in command mode
cnoremap hj <C-C>
" swap buffers
nnoremap <leader>h :bprev<CR>
nnoremap <leader>l :bnext<CR>
" swap tabs
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
"

call plug#begin()
" plugins go here

Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'jparise/vim-graphql'

call plug#end()

" plugin specific keybinds

" fzf
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Ag<CR>
nnoremap <leader>b :Buffers<CR>

" NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <C-n> :NERDTreeToggle<CR>

filetype plugin indent on

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

source ~/.local/share/nvim/site/autoload/coc_settings.vim
" Security

set modelines=0

" Show line numbers

set number
set relativenumber

" Show file stats

set ruler

" Encoding

set encoding=utf-8

" Whitespace

set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
" use % to jump between pairs
set matchpairs+=<:> 
runtime! macros/matchit.vim

" Move up/down editor lines

nnoremap j gj
nnoremap k gk

" Change split navigation
" This is a life-saver -- I hate cord key bindings like in emacs
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map <Leader> x to close current buffer
" Use this a lot
nmap <Leader>x :bd<CR>

" Faster save
" I really do :w<cr> often -- this is faster.
nnoremap <Leader>w :w<CR>

" Disable arrowkeys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Allow hidden buffers

set hidden

" Rendering

set ttyfast

" Status bar

set laststatus=2

" Last line

set showmode
set showcmd

" Searching

nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" Clear search highlight with <leader><space>
map <leader><space> :let @/=''<cr>

" Color scheme (terminal)

colorscheme nord

" buffer binds
" list buffers, prompt int
nnoremap gb :buffers<CR>:buffer<Space>

