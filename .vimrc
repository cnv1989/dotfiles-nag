set nocompatible		" required
filetype off			" required
set clipboard=unnamed

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin('~/.vim/bundle/')

Plugin 'gmarik/Vundle.vim'

" Plugins Start

Plugin 'valloric/youcompleteme'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-fugitive'


" Plugins End

call vundle#end()		" required
filetype plugin indent on	" required
" show existing tab with 4 spaces width
set tabstop=4
set softtabstop=4

" when indenting with '>' use 4 spaces width
set shiftwidth=4
" On pressing tab instser 4 spaces
set expandtab
set autoindent
set backspace=indent,eol,start
let python_highlight_all=1
syntax on

