"To convert to tabs Ctrl + W + T

"create Tabs
nnoremap <C-J> :tabnext<CR>
nnoremap <C-K> :tabprevious<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-x> :tabclose<CR>
"use Ctags
set tags=./tags;

" Use ack instead of grep
set grepprg=ack

set laststatus=2
"set statusline=Filename:%t\ Line:\ %l\ Col:\ %c
set statusline=%{expand('%:p:h:t')}/%t
"set statusline+=\ Line:\ %l\ Col:\ %c

set syntax=ruby
hi Search ctermbg=yellow
hi Search ctermfg=red
set background=dark

syntax on
set tabstop=2
set textwidth=80
set shiftwidth=2
set expandtab
set softtabstop=2
set rnu
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

nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
inoremap jj <Esc>
imap jj <Esc>
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab
"Python settings
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
"autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql

set hlsearch
set cursorline

"Highlight selection with color
highlight clear CursorLine to clear the current cusorline hl
highlight CursorLine gui=underline cterm=underline
highlight Visual cterm=bold ctermbg=red ctermfg=NONE

let g:ale_linters = {'shell': ['bash']}
" Leader gf copies word under cursor to ctrlp
nmap <leader>gf :CtrlP<CR><C-\>w
