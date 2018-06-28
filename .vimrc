" Kevin's Vim

" Remapping for marks
nnoremap ' `
nnoremap ` '

" Use vim settings over Vi
set nocompatible

" Modifies backspace
set backspace=indent,eol,start

" Custom to source this file
map <leader> rr :source ~/.vimrc<CR>

" filetype detection + language dependent indenting
filetype plugin indent on

" show line numbers
set number

" Allow multiple buffers
" set hidden

" C-style indentation
set cindent

" Title for vim
set title

" Flash screen when wrong stuff
set visualbell

" Modifying tab and indentation
" tab is 2 spaces long
set tabstop=2
" indenting with > is 2 spaces
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab
" Use soft tabs for easier readibility throughout systems
set softtabstop=2

" colors and schemes
colorscheme slate
set guifont=Monospace\ Bold\ 11
highlight Special ctermbg=Red

syntax enable
"""""""""""""""""""" Stolen from bae""""""""""""""
" Incremental searching, un/ignores case when searching
" ignores case during search regardless
set incsearch
set smartcase
set ignorecase

" Show brackets around in matching ones
set showmatch

" bottom right, shows typed words
set showcmd

" copies indentation when pasting
"set copyindent
