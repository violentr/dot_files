syntax on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set number
autocmd BufWritePre * %s/\s\+$//e
filetype plugin indent on

execute pathogen#infect()
call pathogen#helptags() "generate helptags for everything in ‘runtimepath’
map <C-n> :NERDTreeToggle<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim
let mapleader = "\\"
nnoremap <leader>r :!rspec %<cr>
nnoremap <leader>R :!rspec <cr>
inoremap jk <Esc>
autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql
set hlsearch
set cursorline
