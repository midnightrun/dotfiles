if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" **Plugins**
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'beikome/cosme.vim'
Plug 'dense-analysis/ale'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" **Colorscheme**
colorscheme cosme

" **General**
set number
" Display unprintable characters
set list
set listchars=tab:•\ ,trail:•,extends:»,precedes:«

" **netrw**
let g:netrw_banner=0

" **ALE**
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

" Zen Mode
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
