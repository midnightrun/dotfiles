if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" **Plugins**
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'bazelbuild/vim-bazel'
Plug 'dense-analysis/ale'
Plug 'google/vim-maktaba'
Plug 'govim/govim'
Plug 'hashivim/vim-terraform'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'kadekillary/turtles'
Plug 'mrk21/yaml-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'sebdah/vim-delve'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wadackel/vim-dogrun'
call plug#end()

" **Colorscheme**
colorscheme turtles
set termguicolors

let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"vim-airline config
let g:airline_theme = 'turtles'
let g:airline_powerline_fonts = 1                       "displays arrows, terminal must have a powerline font
let g:airline#extensions#tabline#enabled = 1            "automatically display all buffers (even one tab)
let g:airline#extensions#tabline#formatter = 'default'

set laststatus=2
syntax on

" **General**
set number
set bs=2
set encoding=UTF-8

" Change path to current buffer location
autocmd BufEnter * silent! lcd %:p:h

" Display unprintable characters
set list
set listchars=tab:•\ ,trail:•,extends:»,precedes:«

" Activations
au VimEnter * RainbowParentheses

" **netrw**
let g:netrw_banner=0

" **ALE**
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

let g:ale_linters = {
\   'terraform': ['terraform-lsp'],
\   'go': ['gopls', 'golangci-lint'],
\}

let g:ale_fixers = {
\   'terraform': ['terraform'],
\   'go': ['gofmt', 'goimports'],
\}

let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" **govim**
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set mouse=a
set updatetime=500
set balloondelay=250
set signcolumn=yes
set autoindent
set smartindent
set backspace=2

filetype indent on
filetype plugin on

if has("patch-8.1.1904")
  set completeopt+=popup
  set completepopup=align:menu,border:off,highlight:Pmenu
endif

" **CoC**
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" **Terraform**
let g:terraform_align=1
let g:terraform_fold_sections=0
let g:terraform_remap_spacebar=1
let g:terraform_commentstring='//%s'
let g:terraform_fmt_on_save=1

" **Mappings**
" General
let mapleader = ","
"Leave Insert Mode by pressing jj
imap jj <Esc>

" Navigation mapping
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" netrw
" Opening netrw browser
nmap <C-W><C-E> :Explore<CR>
" Return to file
nmap <C-W><C-R> :b<CR>

" CoC mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Zen Mode
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'DarkGray'

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'

" Default: 0.5
let g:limelight_default_coefficient = 0.5

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s*$\n\zs'
let g:limelight_eop = '^\s*$'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = 10

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nmap <Leader>l :Goyo<CR>
xmap <Leader>l :Goyo<CR>

" Fuzzy search
nmap <Leader>f :Rg<CR>
xmap <Leader>f :Rg<CR>

" ***Filetype***
autocmd FileType json syntax match Comment +\/\/.\+$+
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
