if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" **Plugins**
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'aklt/plantuml-syntax'
Plug 'bazelbuild/vim-bazel'
Plug 'bouk/vim-markdown'
Plug 'chr4/nginx.vim'
Plug 'dense-analysis/ale'
Plug 'google/vim-maktaba'
Plug 'hashivim/vim-terraform'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/seoul256.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'sebdah/vim-delve'
Plug 'tpope/vim-fugitive'
Plug 'udalov/kotlin-vim'
call plug#end()

" colorscheme
colorscheme seoul256-light

" lightline config
set noshowmode
set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

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
let g:netrw_localrmdir='rm -r'

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

" fzf
let g:fzf_preview_window = 'down:60%'

" Fuzzy search text
nmap <Leader>f :Rg<Space>
xmap <Leader>f :Rg<Space>

" Fuzzy search files
nmap <silent> <Leader>p :call FzfOmniFiles()<CR>
xmap <silent> <Leader>p :call FzfOmniFiles()<CR>

" Other mappings
nmap <leader><leader> :Commands<CR>

" fzf helper functions
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

" ***Filetype***
autocmd FileType json syntax match Comment +\/\/.\+$+
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au! BufNewFile,BufReadPost *.gradle set filetype=groovy
au! BufNewFile,BufReadPost *.hcl set filetype=terraform
au! BufNewFile,BufReadPost *.kts set filetype=kotlin

" zettelkasten
function! Note(...)
  let path = strftime("%Y%m%d%H%M")." ".trim(join(a:000)).".md"
  execute ":e " . fnameescape(path)
  0r ~/.vim/templates/zk.md
endfunction
command! -nargs=* Note call Note(<f-args>)

function! ZettelkastenSetup()
  if expand("%:t") !~ '^[0-9]\+'
    return
  endif
  " syn region mkdFootnotes matchgroup=mkdDelimiter start="\[\["    end="\]\]"

  inoremap <expr> <plug>(fzf-complete-path-custom) fzf#vim#complete#path("rg --files -t md \| sed 's/^/[[/g' \| sed 's/$/]]/'")
  imap <buffer> [[ <plug>(fzf-complete-path-custom)

  function! s:CompleteTagsReducer(lines)
    if len(a:lines) == 1
      return "#" . a:lines[0]
    else
      return split(a:lines[1], '\t ')[1]
    end
  endfunction

  inoremap <expr> <plug>(fzf-complete-tags) fzf#vim#complete(fzf#wrap({
        \ 'source': 'zkt-raw',
        \ 'options': '--multi --ansi --nth 2 --print-query --exact --header "Enter without a selection creates new tag"',
        \ 'reducer': function('<sid>CompleteTagsReducer')
        \ }))
  imap <buffer> # <plug>(fzf-complete-tags)
endfunction

" Don't know why I can't get FZF to return {2}
function! InsertSecondColumn(line)
  " execute 'read !echo ' .. split(a:e[0], '\t')[1]
  exe 'normal! o' .. split(a:line, '\t')[1]
endfunction

function! SuperTab()
	let l:part = strpart(getline('.'), col('.') - 2, 1)
	if (l:part =~ '^\W\?$')
		return "\<Tab>"
	else
		return "\<C-n>"
	endif
endfunction

imap <Tab> <C-R>=SuperTab()<CR>
