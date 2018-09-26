set t_Co=256
syntax on

set shell=bash
set foldmethod=marker

set nocompatible              " be iMproved, required
filetype off                  " required

let maplocalleader="\\"

" plugin management {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

nnoremap <leader>pi <esc>:w<cr>:source ~/.vimrc<cr>:PluginInstall<cr>
nnoremap <leader>pc <esc>:w<cr>:source ~/.vimrc<cr>:PluginClean<cr>
nnoremap <leader>pu :PluginUpdate<cr>

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" }}}
" timetracking {{{
Plugin 'termoshtt/toggl.vim'
"let g:toggl_api_token = ""
"let g:toggl_workspace_id = 123
Plugin 'wakatime/vim-wakatime'

" }}}
" colorschemes {{{
Plugin 'NLKNguyen/papercolor-theme' " PaperColor
colorscheme afterglow

" }}}
" unsorted plugins {{{
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'scy/vim-mkdir-on-write'
Plugin 'vim-jp/vital.vim'
Plugin 'mattn/webapi-vim'
Plugin 'tpope/vim-speeddating'

Plugin 'tikhomirov/vim-glsl'
Plugin 'ap/vim-css-color'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'purescript-contrib/purescript-vim'
Plugin 'moll/vim-node'
Plugin 'posva/vim-vue'
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-expand-region' " + -
Plugin 'mattn/emmet-vim' " c-y,
Plugin 'AndrewRadev/splitjoin.vim' " gS gJ
Plugin 'prettier/vim-prettier', { 'do': 'npm install' }
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'dai-shi/es-beautifier', {'rtp': 'contrib/vim', 'external_commands': 'node', 'build_commands': 'npm', 'build': {'others': 'npm install --only=production'}}
"Plugin 'kshenoy/vim-signature'
Plugin 'mbbill/undotree'
nnoremap <leader>uu :UndotreeToggle<cr>
Plugin 'Yggdroot/indentLine'
let g:indentLine_color_term = 236
let g:indentLine_char = '|'
autocmd FileType json :IndentLinesDisable


" }}}
" note taking {{{
Plugin 'metakirby5/codi.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'junegunn/limelight.vim'
Plugin 'itchyny/calendar.vim'
Plugin 'RRethy/vim-illuminate'
Plugin 'vimwiki/vimwiki'
let g:Illuminate_delay = 1

" toggle scratchpad
nnoremap <leader>ns :Codi!!<cr>

let g:notes_list_bullets = ['*', '-', '+']
let g:notes_directories = [ '/home/user/.vim/bundle/vim-notes/misc/notes/user', '/home/user/uni/notes' ]
let g:notes_conceal_code = 0
let g:notes_conceal_italic = 0
let g:notes_conceal_bold = 0
let g:notes_conceal_url = 0
let g:notes_unicode_enabled = 0

" open notes
nnoremap <leader>nn :Note<space>
vnoremap <leader>nn :NoteFromSelectedText<cr>
nnoremap <leader>nN :Note<cr>
" search notes
nnoremap <leader>ns :SearchNotes<space>
nnoremap <leader>nr :RelatedNotes<cr>
nnoremap <leader>nt :RecentNotes<cr>
" toggle limelight
nnoremap <leader>nl :Limelight!!<cr>
" start calendar
nnoremap <leader>nc :Calendar<cr>



" }}}
" text-object related {{{
Plugin 'wellle/targets.vim'
Plugin 'tpope/vim-surround'
Plugin 'bkad/CamelCaseMotion'

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e


" }}}
" git {{{
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
nnoremap <Leader>gs :Gstatus<cr><c-w>J
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gc :Gcommit<cr><c-w>J
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gm :Gmove<cr>
nnoremap <Leader>gl :Glog<cr>
nnoremap <Leader>gb :Gbrowse<cr>
nnoremap <Leader>gw :Gwrite<cr>
nnoremap <Leader>gp :Gpull<cr>
nnoremap <Leader>gP :Gpush<cr>

" }}}
" gist {{{
Plugin 'mattn/gist-vim'

nnoremap <leader>hh <esc>:Gist -a<cr>
nnoremap <leader>hs <esc>:Gist -p<cr>
nnoremap <leader>hp <esc>:Gist -P<cr>
vnoremap <leader>hh <esc>:Gist -a<cr>
vnoremap <leader>hs <esc>:Gist -p<cr>
vnoremap <leader>hp <esc>:Gist -P<cr>

" }}}
" status line {{{
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

" }}}
" autocomplete {{{
Plugin 'othree/jspc.vim'
Plugin 'ternjs/tern_for_vim', { 'do': 'npm i' }
setlocal ofu=syntaxcomplete#Complete
set completeopt-=preview

inoremap <c-c> <c-x><c-o>

" }}}
" indent guides {{{
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=none
hi IndentGuidesEven ctermbg=red

" }}}
" eslint {{{
Plugin 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'json': ['eslint'],
\   'typescript': ['tslint'],
\   'vue': ['eslint'],
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

" }}}
" react {{{
Plugin 'mxw/vim-jsx'

" }}}
" angular {{{
"Plugin 'burnettk/vim-angular'

" }}}
" javascript {{{
augroup js-init
  au FileType javascript setlocal omnifunc=jspc#omni
  au FileType javascript nnoremap <buffer> <Leader>e :call EsBeautifier()<cr>
  au FileType javascript vnoremap <buffer> <Leader>e :call RangeEsBeautifier()<cr>
augroup END

" }}}
" typescript {{{
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

" }}}
" Ultisnips {{{
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsSnippetDirectories=["/home/user/UltiSnips"]

let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}
" regex {{{
Plugin 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" }}}
" rust {{{
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

" }}}
" nerdtree {{{
Plugin 'scrooloose/nerdtree'

let g:NERDTreeWinSize=20

" }}}
" docker  {{{
Plugin 'docker/docker'

" }}}
" authoring vim plugins {{{
Plugin 'tpope/vim-scriptease'

" }}}
" end plugin management {{{
call vundle#end()
filetype plugin indent on

" }}}
" tabs {{{
set tabstop=2
set softtabstop=0 expandtab
set shiftwidth=2
set smarttab
set autoindent

" }}}
" ruler {{{
set nu
set rnu

" }}}
" bracket matching {{{
set showmatch
set matchtime=1

" }}}
" leader meta (v) {{{
nnoremap <leader>ve :split $MYVIMRC<cr>
nnoremap <leader>vE :e $MYVIMRC<cr>
nnoremap <leader>vv :source $MYVIMRC<cr>
nnoremap <leader>vu :UltiSnipsEdit<cr>
nnoremap <leader>vU :UltiSnipsEdit<space>

" }}}
" leader opening (o) {{{
" open current file in a new tab
nnoremap <leader>oo :tabe %<cr>
" open terminal
nnoremap <leader>ot :term zsh<cr>
" toggle nerdtree
nnoremap <leader>on :NERDTreeToggle<cr>

" }}}
" leader settings (s) {{{
nnoremap <leader>sp :set paste!<cr>

function! ToggleVirtualEdit()
  if strlen(&virtualedit) == 0
    set virtualedit=all
  else
    set virtualedit=
  endif
endfunction
nnoremap <leader>sv :call ToggleVirtualEdit()<cr>

" }}}
" leader echos (e) {{{
" echo resolved path under cursor
nnoremap <leader>ep :echo resolve(fnamemodify(expand('%'), ':p:h') . '/' . expand('<cfile>'))<cr>

" }}}
" leader window (w) {{{
" redraw windows
nnoremap <leader>wr :redraw!<cr>

" }}}
" leader quick-access search/exec (z) {{{
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

" }}}
" leader run stuff (r) {{{
" run current file in shell
nnoremap <leader>rr :w !bash<cr>
" run current visual selection in shell
" when you press :, it also adds '<,'>
vnoremap <leader>rr :w !bash<cr>

" }}}
" remap buffer writing/quitting {{{
inoremap <c-s> <esc>:w<cr>
nnoremap <c-s> <esc>:w<cr>
inoremap <c-q> <esc>:q<cr>
nnoremap <c-q> <esc>:q<cr>
inoremap <c-Q> <esc>:q<cr><c-w>k
nnoremap <c-Q> <esc>:q<cr><c-w>k

" }}}
" char size limit indicator {{{
hi colorcolumn ctermbg=brown
autocmd FileType javascript,vim call matchadd('colorcolumn', '\%80v', 100)

" }}}
" local vimrc {{{
set exrc
" }}]
