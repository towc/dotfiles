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
Plugin 'embear/vim-localvimrc'
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0

"Plugin 'yuratomo/w3m.vim'

"Plugin 'vim-scripts/sketch.vim'
Plugin 'vim-scripts/DrawIt'

Plugin 'tikhomirov/vim-glsl'
Plugin 'ap/vim-css-color'
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-expand-region' " + -
Plugin 'mattn/emmet-vim' " c-y,
Plugin 'AndrewRadev/splitjoin.vim' " gS gJ
"Plugin 'kshenoy/vim-signature'
Plugin 'mbbill/undotree'
nnoremap <leader>uu :UndotreeToggle<cr>
Plugin 'Yggdroot/indentLine'
let g:indentLine_color_term = 236
let g:indentLine_char = '|'
set concealcursor=
autocmd FileType json :IndentLinesDisable
nnoremap <leader>ni :IndentLinesToggle<cr>
" }}}
" note taking (n) {{{
Plugin 'metakirby5/codi.vim'
Plugin 'xolox/vim-misc'
Plugin 'junegunn/goyo.vim'
nnoremap <leader>ng :Goyo<cr>:set linebreak!<cr>:IndentLinesToggle<cr>
"Plugin 'xolox/vim-notes'
Plugin 'junegunn/limelight.vim'
Plugin 'itchyny/calendar.vim'
Plugin 'RRethy/vim-illuminate'
Plugin 'vimwiki/vimwiki'
let g:Illuminate_delay = 1

" toggle scratchpad
nnoremap <leader>ns :Codi!!<cr>

let g:vimwiki_conceallevel = 0
let g:vimwiki_list = [{ 'path': '~/uni/notes', 'syntax': 'markdown' }, { 'path': '~/git/github/towc/uni-cs-kcl-2018', 'syntax': 'markdown' }]
" see ~/.vim/after/ftplugin/vimwiki.vim

"" open notes
"nnoremap <leader>nn :Note<space>
"vnoremap <leader>nn :NoteFromSelectedText<cr>
"nnoremap <leader>nN :Note<cr>
"" search notes
"nnoremap <leader>ns :SearchNotes<space>
"nnoremap <leader>nr :RelatedNotes<cr>
"nnoremap <leader>nt :RecentNotes<cr>
" toggle limelight
nnoremap <leader>nl :Limelight!!<cr>
" start calendar
nnoremap <leader>nc :Calendar<cr>

" markdown
Plugin 'shime/vim-livedown'
au FileType markdown nnoremap <leader>nm :LivedownToggle<cr>
let g:livedown_browser = 'opera'

function! UseBookMode()
    LivedownPreview
    Goyo
    IndentLinesDisable
    Limelight
    g:saving_at_every_edit = 0
    call ToggleSaveEveryEdit()
    set linebreak
    set wrap
    nnoremap j gj
    nnoremap k gk
    " add a note
    let @i = '?note-index2f-lyt"a<a name="note-content-pyiwA" href="#note-index-pA"><sup>pA</sup></a>Go</p><a name="note-index-pA" href="#note-content-pA">pa</a>: </p>Bi'
endfunction
nnoremap <leader>nb :call UseBookMode()<cr>
" for books: \nm\ng\sns
" }}}
" text-object related {{{
Plugin 'wellle/targets.vim'
Plugin 'tpope/vim-surround'
"Plugin 'bkad/CamelCaseMotion'
"
"map <silent> w <Plug>CamelCaseMotion_w
"map <silent> b <Plug>CamelCaseMotion_b
"map <silent> e <Plug>CamelCaseMotion_e


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
" c++ {{{
Plugin 'vim-scripts/OmniCppComplete'
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp map <leader>tt :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
au FileType cpp nnoremap <leader>rr :!g++ <c-r>=expand("%:p")<cr> -o tmp-out -Wall -Weffc++ -Wextra -Wsign-conversion && ./tmp-out<cr>
au FileType cpp nnoremap <leader>ro :!g++ <c-r>=expand("%:p")<cr> -o tmp-out -O3 -Wall -Weffc++ -Wextra -Wsign-conversion && ./tmp-out<cr>
set tags+=~/.vim/tags/cpp

"Plugin 'vim-scripts/Conque-GDB'

"Plugin 'Rip-Rip/clang_complete'
"let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'

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
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'h': ['clang-format'],
\   'hpp': ['clang-format'],
\   'rust': ['rustfmt'],
\   'python': ['autopep8'],
\}
map <leader>f :ALEFix<CR>
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'json': ['eslint'],
\   'typescript': ['tsserver'],
\   'rust': ['rustc'],
\   'sql': ['sqlint'],
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
  au FileType javascript,jsx nnoremap <buffer> <Leader>td :TernDef<cr>
  au FileType javascript,jsx nnoremap <buffer> <Leader>tx :TernDoc<cr>
  au FileType javascript,jsx nnoremap <buffer> <Leader>tt :TernType<cr>
  au FileType javascript,jsx nnoremap <buffer> <Leader>tr :TernRefs<cr>
  au FileType javascript,jsx nnoremap <buffer> <Leader>tn :TernRename<cr>
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
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'purescript-contrib/purescript-vim'
Plugin 'moll/vim-node'
Plugin 'posva/vim-vue'
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'dai-shi/es-beautifier', {'rtp': 'contrib/vim', 'external_commands': 'node', 'build_commands': 'npm', 'build': {'others': 'npm install --only=production'}}
Plugin 'prettier/vim-prettier', { 'do': 'npm install' }
augroup js-init
  au FileType javascript setlocal omnifunc=jspc#omni
  au FileType javascript nnoremap <buffer> <Leader>e :call EsBeautifier()<cr>
  au FileType javascript vnoremap <buffer> <Leader>e :call RangeEsBeautifier()<cr>
  au FileType javascript nnoremap <buffer> <leader>rr :!node <c-r>=expand("%:p")<cr><cr>
augroup END

" }}}
" vue {{{
" format element. F<ea<cr><esc>f>i<cr><80><esc>. 80 is backspace
au FileType vue let @i = "F<eaf>i�kb"
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
" java {{{
"source ~/.vim/bundle/eclim/plugin/eclim.vim
au FileType java inoremap <c-c> <c-x><c-u>
au FileType java nnoremap <leader>f :%JavaFormat<cr>
au FileType java vnoremap <leader>f :JavaFormat<cr>

au FileType java nnoremap <leader>tr :JavaRename<space>
au FileType java nnoremap <leader>tm :JavaMove<space>
au FileType java nnoremap <leader>th :JavaHierarchy<space>
au FileType java nnoremap <leader>tc :JavaCallHierarchy<space>
au FileType java nnoremap <leader>to :JavaOutline<space>
au FileType java nnoremap <leader>ti :JavaImport<cr>

au FileType java nnoremap <leader>tnc :JavaNew class<space>
au FileType java nnoremap <leader>tni :JavaNew interface<space>
au FileType java nnoremap <leader>tna :JavaNew abstract<space>
au FileType java nnoremap <leader>tne :JavaNew enum<space>
au FileType java nnoremap <leader>tn@ :JavaNew @interface<space>

au FileType java nnoremap <leader>tgc :JavaConstructor<space>
au FileType java vnoremap <leader>tgc :JavaConstructor<cr>
au FileType java nnoremap <leader>tgg :JavaGet<space>
au FileType java vnoremap <leader>tgg :JavaGet<cr>
au FileType java nnoremap <leader>tgs :JavaSet<space>
au FileType java vnoremap <leader>tgs :JavaSet<cr>
au FileType java nnoremap <leader>tgS :JavaGetSet<space>
au FileType java vnoremap <leader>tgS :JavaGetSet<cr>
au FileType java nnoremap <leader>tgG :JavaGetSet<space>
au FileType java vnoremap <leader>tgG :JavaGetSet<cr>

au FileType java nnoremap <leader>r :Java<cr>
" }}}
" assembly {{{
Plugin 'VelkyVenik/vim-avr' " always sets type to avr. Better fix it somehow
au FileType asm set ft=avr
au FileType avr set tabstop=8
au FileType avr set softtabstop=0 noexpandtab
au FileType avr set shiftwidth=8
" }}}
" python {{{
Plugin 'davidhalter/jedi-vim' " autocomplete
let g:jedi#show_call_signatures = "1"
let g:jedi#goto_command             = "<leader>td"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command    = "K"
let g:jedi#usages_command           = "<leader>tr"
let g:jedi#completions_command      = "<C-Space>"
let g:jedi#rename_command           = "<leader>tn"

Plugin 'tweekmonster/django-plus.vim'

au FileType python nnoremap <leader>rr :!python3 <c-r>=expand("%:p")<cr><cr>
au FileType python nnoremap <leader>rt :!pytest <c-r>=expand("%:p")<cr><cr>
" }}}
" Qt {{{
Plugin 'peterhoeg/vim-qml'
au FileType qml nnoremap <buffer> <leader>rr :!qmlscene <c-r>=expand("%:p")<cr><cr>
au FileType qml nnoremap <buffer> <leader>rm :!QT_QUICK_CONTROLS_STYLE=material qmlscene <c-r>=expand("%:p")<cr><cr>
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
let g:racer_cmd = '~/.cargo/bin/racer'
let g:racer_experimental_completer = 1

augroup rust-mappings
  au FileType rust nmap <leader>td <Plug>(rust-def)
  au FileType rust nmap <leader>tD <Plug>(rust-def-split)
  au FileType rust nmap <leader>tx <Plug>(rust-doc)

  au FileType rust nnoremap <leader>rr :!rustc <c-r>=expand('%:p')<cr> -o tmp-out-rs && echo compilation done && ./tmp-out-rs<cr>
  au FileType rust nnoremap <leader>ro :!rustc -O <c-r>=expand('%:p')<cr> -o tmp-out-rs && echo optimized compilation done && ./tmp-out-rs<cr>
augroup END

" }}}
" nerdtree {{{
Plugin 'scrooloose/nerdtree'

let g:NERDTreeWinSize=20

" }}}
" docker  {{{
Plugin 'docker/docker'

" }}}
" sql {{{
"Plugin 'vim-scripts/sql.vim'
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
set bs=2

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
if empty($MYVIMRC)
  let $MYVIMRC = "~/.vimrc"
endif
nnoremap <leader>ve :split $MYVIMRC<cr>
nnoremap <leader>vE :e $MYVIMRC<cr>
nnoremap <leader>vv :source $MYVIMRC<cr>
nnoremap <leader>vu :UltiSnipsEdit<cr>
let g:UltiSnipsEditSplit = "horizontal"

nnoremap <leader>vU :UltiSnipsEdit<space>
nnoremap <leader>vr :runtime after/ftplugin/*<cr>
nnoremap <leader>vs :syntax sync fromstart<cr>
nnoremap <leader>vS :redraw!<cr>

" }}}
" loader insert (i) {{{
nnoremap <leader>id :pu=strftime('%c')<cr>
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
nnoremap <leader>sfi :set foldmethod=indent<cr>
nnoremap <leader>sfs :set foldmethod=syntax<cr>

function! ToggleVirtualEdit()
  if strlen(&virtualedit) == 0
    set virtualedit=all
  else
    set virtualedit=
  endif
endfunction
nnoremap <leader>sv :call ToggleVirtualEdit()<cr>

let g:saving_at_every_edit = 0
function! ToggleSaveEveryEdit()
  if g:saving_at_every_edit == 0
    let g:saving_at_every_edit = 1
    augroup SaveAtEveryEdit
      au TextChanged,TextChangedI <buffer> silent write
    augroup END 
  else
    let g:saving_at_every_edit = 0
    " delete group
    au! SaveAtEveryEdit
  endif
endfunction
nnoremap <leader>ss :call ToggleSaveEveryEdit()<cr>

" note settings {{{
nnoremap <leader>sns :set spell!<cr>
" }}}
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
vnoremap <leader>zv :<c-u>CAg <c-r>*<cr>
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
" leader refactoring (t) {{{
nnoremap <leader>tn :%s/\<<c-r><c-w>\>//g<left><left>
nnoremap <leader>tN :%s/\<<c-r><c-w>\>//g<left><left>
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
