set nocompatible              " be iMproved, required
set clipboard=unnamed
filetype off 
syntax on
let &t_Co=256
let mapleader = "`" 
set number
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

nnoremap <C-tab> :tabnext<CR>
nnoremap <C-S-tab> :tabprevious<CR>

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
let g:ycm_min_num_of_chars_for_completion = 1
