if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

syntax on
set background=dark
set number

let g:netrw_banner=0

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif

" netrw key mapping
nmap <C-W><C-E> :Explore<CR>
nmap <C-W><C-B> :b<CR>

" buffer movement mapping
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

imap <C-l> <C-X><C-O>

" plugin setup
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'slashmili/alchemist.vim'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
let g:airline_theme='dracula'

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_def_mode='gopls'

Plug 'mileszs/ack.vim'

call plug#end()
