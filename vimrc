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

Plug 'drewtempelmeyer/palenight.vim'

Plug 'itchyny/lightline.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'mileszs/ack.vim'

Plug 'hashivim/vim-terraform'

call plug#end()

syntax on
set background=dark

" lightline config
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ }

if (has("termguicolors"))
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	
	set background=dark
	colorscheme palenight
endif

set number

let g:netrw_banner=0

" Terraform configs
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
let g:terraform_commentstring='//%s'
let g:terraform_fmt_on_save=1

let g:go_def_mode='gopls'

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
au VimEnter * RainbowParentheses

