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
"git-blame.vim
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

inoremap ;; <Esc>
set hlsearch
set cursorline
augroup filetype javascript syntax=javascript
autocmd FileType typescript :set makeprg=tsc

"emmit settings
let g:user_emmet_install_global = 1
autocmd FileType html,css EmmetInstall

"ALE
map <C-a> :ALEToggle<CR>
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction
autocmd BufWritePre * call TrimWhiteSpace()
set hlsearch

"highlight selection with color
highlight clear CursorLine to clear the current cusorline hl
highlight CursorLine gui=underline cterm=underline
highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE
