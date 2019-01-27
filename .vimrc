set syntax=ruby
hi Search ctermbg=cyan
hi Search ctermfg=black
set background=dark
syntax on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set number
set mouse=a
autocmd BufWritePre * %s/\s\+$//e
filetype plugin indent on

execute pathogen#infect()
call pathogen#helptags() "generate helptags for everything in ‘runtimepath’
map <C-n> :NERDTreeToggle<CR>
map <C-b> :buffers<CR>
map <C-a> :ALEToggle<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim
let mapleader = "\\"
nnoremap <leader>r :!rspec %<cr>
nnoremap <leader>R :!rspec <cr>
inoremap ;; <Esc>

autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
autocmd FileType * set tabstop=2|set shiftwidth=2|set noexpandtab
"Python settings
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
"autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql

set hlsearch
set cursorline
