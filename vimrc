set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mileszs/ack.vim'
Plug 'hashivim/vim-terraform'

call plug#end()

set t_co=256
set background=dark
set cursorline
set omnifunc=syntaxcomplete#Complete
set noshowmode

syntax on

filetype plugin on

let g:dracula_colorterm = 0
let g:dracula_italic=0
colors dracula

set number
let g:netrw_banner=0

"vim-airline config
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1                       "displays arrows, terminal must have a powerline font

" Terraform configs
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
let g:terraform_commentstring='//%s'
let g:terraform_fmt_on_save=1

" vim-go configs
let g:go_def_mode='gopls'
let g:go_fmt_command='goimports'
let g:go_echo_go_info = 1

" for GitGutter, making Vim update faster
set updatetime=100

" auto indent on save for Elixir
let g:mix_format_on_save=1

if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif

nmap <C-W><C-E> :Explore<CR>
nmap <C-W><C-B> :b<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

imap <C-l> <C-X><C-O>

autocmd BufWritePost *.json silent :%!python -m json.tool
autocmd BufWritePost *.yaml setlocal ts=2 sts=2 sw=2 expandtab
au VimEnter * RainbowParentheses
