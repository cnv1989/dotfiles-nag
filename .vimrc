set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set clipboard=unnamed
filetype off 
syntax on
let &t_Co=256
let mapleader = "`" 
set number
set paste
set nowrap
set autoindent
set cindent
set hlsearch
set autochdir
set tabstop=4 softtabstop=0 expandtab shiftwidth=4
vmap <C-c> "+y
filetype plugin indent on
set cursorline
hi CursorLine guibg=white 
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"split up
nmap <silent> <leader><UP> :wincmd k<CR>
"split down
nmap <silent> <leader><DOWN> :wincmd j<CR>
"split left
nmap <silent> <leader><LEFT> :wincmd h<CR>
"split right
nmap <silent> <leader><RIGHT> :wincmd l<CR>
"vsplit
nmap <silent> <leader>v :vsplit<CR>
"hsplit
nmap <silent> <leader>h :split<CR>
nmap <silent> <leader>] :tabnext<CR>
nmap <silent> <leader>[ :tabprev<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

nnoremap <leader>t :TagbarToggle<CR>
set runtimepath^=~/.vim/bundle/ctrlp.vim
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
" Make backspace work
set backspace=indent,eol,start

"Configuration for ~/.vimrc:
"Bind <leader>y to forward last-yanked text to Clipper
nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_min_num_of_chars_for_completion = 2

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = 0
