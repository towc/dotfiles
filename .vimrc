set t_Co=256
syntax on
set background=dark
colorscheme afterglow

set shell=bash

set nocompatible              " be iMproved, required
filetype off                  " required

let maplocalleader="\\"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'Raimondi/delimitMate'
Plugin 'mattn/emmet-vim'
Plugin 'prettier/vim-prettier', { 'do': 'npm install' }
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'dai-shi/es-beautifier', {'rtp': 'contrib/vim', 'external_commands': 'node', 'build_commands': 'npm', 'build': {'others': 'npm install --only=production'}}

" git
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
map <Leader>gs <Esc>:Gstatus<Enter>
map <Leader>gd <Esc>:Gdiff<Enter>
map <Leader>gc <Esc>:Gcommit<Enter>
map <Leader>gb <Esc>:Gblame<Enter>
map <Leader>gm <Esc>:Gmove<Enter>
map <Leader>gg <Esc>:Ggrep<Enter> map <Leader>gl <Esc>:Glog<Enter>
map <Leader>gb <Esc>:Gbrowse<Enter>
map <Leader>gw <Esc>:Gwrite<Enter>
map <Leader>gp <Esc>:Gpull<Enter>
map <Leader>gP <Esc>:Gpush<Enter>

" status
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

" comments Plugin 'tomtom/tcomment_vim'

" autocomplete
Plugin 'othree/jspc.vim'
Plugin 'ternjs/tern_for_vim', { 'do': 'npm i' }

" indent guides
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=none
hi IndentGuidesEven ctermbg=red

" eslint
Plugin 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'json': ['eslint'],
\   'typescript': ['tslint'],
\}
map <leader>f :ALEFix<CR>
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'json': ['eslint'],
\   'typescript': ['tsserver'],
\   'rust': ['rustfmt'],
\}

" let g:ale_sign_error = '█'
" let g:ale_sign_warning = '█' " '𝄚'

" highlight ALEErrorSign ctermbg=none ctermfg=darkyellow
" highlight ALEWarningSign ctermbg=none ctermfg=darkyellow
highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline

map <Leader>af <Esc>:ALEFix<Enter>
map <Leader>an <Esc>:ALENext<Enter>

augroup ecma-mappings
  au FileType javascript,jsx nnoremap <Leader>td :TernDef<cr>
  au FileType javascript,jsx nnoremap <Leader>tx :TernDoc<cr>
  au FileType javascript,jsx nnoremap <Leader>tt :TernType<cr>
  au FileType javascript,jsx nnoremap <Leader>tr :TernRefs<cr>
  au FileType javascript,jsx nnoremap <Leader>tn :TernRename<cr>
  au FileType javascript,jsx nnoremap <buffer> <Leader>tb :call EsBeautifier()<cr>
  au FileType javascript,jsx vnoremap <buffer> <Leader>tb :call RangeEsBeautifier()<cr>
augroup END


" react
Plugin 'mxw/vim-jsx'

" angular
"Plugin 'burnettk/vim-angular'

" typescript
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'

augroup ts-mappings
  au FileType typescript map <buffer> <Leader>td <Esc>:TsuDefinition<Enter>
  au FileType typescript map <buffer> <Leader>tt <Esc>:TsuTypeDefinition<Enter>
  au FileType typescript map <buffer> <Leader>tr <Esc>:TsuReferences<Enter>
  au FileType typescript map <buffer> <Leader>ti <Esc>:TsuImplementation<Enter>
  au FileType typescript map <buffer> <Leader>ts <Esc>:TsuSearch<Enter>
  au FileType typescript map <buffer> <Leader>tn <Esc>:TsuRenameSymbol<Enter>
  au FileType typescript map <buffer> <Leader>tN <Esc>:TsuRenameSymbolC<Enter>
  au FileType typescript map <buffer> <Leader>tI <Esc>:TsuImport<Enter>
augroup END

" Ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsSnippetDirectories=["/home/user/UltiSnips"]

let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" regex
Plugin 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" rust
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
set hidden
let g:racer_cmd = "/home/user/.bin/racer"
let g:racer_experimental_completer = 1

augroup rust-mappings
  au FileType rust nmap <leader>td <Plug>(rust-def)
  au FileType rust nmap <leader>tD <Plug>(rust-def-split)
  au FileType rust nmap <leader>tx <Plug>(rust-doc)
augroup END

" common lisp

" nerdtree
Plugin 'scrooloose/nerdtree'
nnoremap <leader>nn :NERDTreeToggle<cr>

let g:NERDTreeWinSize=20

" docker
Plugin 'docker/docker'

call vundle#end() " required
filetype plugin indent on "required

" authoring vim plugins
Plugin 'tpope/vim-scriptease'

" general omnicompletion
setlocal ofu=syntaxcomplete#Complete
set completeopt-=preview

" language mappings
augroup js-init
  au FileType javascript setlocal omnifunc=jspc#omni
  au FileType javascript nnoremap <buffer> <Leader>e :call EsBeautifier()<cr>
  au FileType javascript vnoremap <buffer> <Leader>e :call RangeEsBeautifier()<cr>
augroup END

" random

set tabstop=2
set softtabstop=0 expandtab
set shiftwidth=2
set smarttab

set nu
set rnu
set autoindent

set showmatch
set matchtime=1

" edit and source .vimrc
nnoremap <leader>ve :split $MYVIMRC<cr>
nnoremap <leader>vv :source $MYVIMRC<cr>

" insert js comment
nnoremap <leader>ic mqI//<esc>`qll
" insert semicolon
nnoremap <leader>is mqA;<esc>`q

" open current file in a new tab
nnoremap <leader>oo :tabe %<cr>
" open terminal
nnoremap <leader>ot :term fish<cr>

" settings
nnoremap <leader>sp :set paste!<cr>

function! ToggleVirtualEdit()
  if strlen(&virtualedit) == 0
    set virtualedit=all
  else
    set virtualedit=
  endif
endfunction
nnoremap <leader>sv :call ToggleVirtualEdit()<cr>

" echo resolved path under cursor
nnoremap <leader>ep :echo resolve(fnamemodify(expand('%'), ':p:h') . '/' . expand('<cfile>'))<cr>

" make window taller
nnoremap <leader>wt <c-w>+
" make window shorter
nnoremap <leader>ws <c-w>-
" make window narrower
nnoremap <leader>wn <c-w><
" make window wider
nnoremap <leader>ww <c-w>>
" redraw windows
nnoremap <leader>wr :redraw!<cr>

" buffers
" list buffers and start switch
"nnoremap <leader>zz :buffers<cr>:buffer<space>
" use c-v in fzf to open a vertical split
nnoremap <leader>zz :Buffers<cr>
" like above, but split
"nnoremap <leader>zs :buffers<cr>:sbuffer<space>
" delete current buffer
nnoremap <leader>zq :bdelete<cr>

" fuzzy find
"set path=.,**
"set wildignore+=*/node_modules/*
"nnoremap <leader>zx :find<space>
command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git -g ""'}, <bang>0)
nnoremap <leader>zx :HFiles<cr>
command! -bang -nargs=? -complete=dir HNGFiles
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --skip-vcs-ignores --ignore .git -g ""'}, <bang>0)
nnoremap <leader>zX :HNGFiles<cr>

nnoremap <leader>za :argdo<space>
nnoremap <leader>zA :args<space>

" open non-git-ignored files
nnoremap <leader>zg :GFiles<cr>
nnoremap <leader>zG :GFiles?<cr>

nnoremap <leader>zc :Commits<cr>
nnoremap <leader>zC :BCommits<cr>

nnoremap <leader>zs :Snippets<cr>

" search lines in open buffers
nnoremap <leader>zl :Lines<cr>
nnoremap <leader>zL :BLines<cr>
" search all files in directory
command! -bang -nargs=* CAg call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <leader>zv :CAg<cr>
nnoremap <leader>zV :Ag<cr>

nnoremap <leader>zm :Marks<cr>

" run current file in shell
nnoremap <leader>rr :w !bash<cr>
" run current visual selection in shell
" when you press :, it also adds '<,'>
vnoremap <leader>rr :w !bash<cr>

onoremap p i(

" local vimrc
set exrc
