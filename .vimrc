syntax on
let &t_Co=256
let mapleader = "`" 
set number
set nowrap
set autoindent
set cindent
vmap <C-c> "+y
filetype plugin indent on
set cursorline
hi CursorLine guibg=white 
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
function! NumberToggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	
	endif
endfunc
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

nnoremap <leader>t :TagbarToggle<CR>
nnoremap <Leader>l :call NumberToggle()<cr>
set runtimepath^=~/.vim/bundle/ctrlp.vim
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
" Make backspace work
set backspace=indent,eol,start