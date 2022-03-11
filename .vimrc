set t_co=256
syntax on

set shell=bash
set foldmethod=marker

set nocompatible              " be iMproved, required
filetype off                  " required

set nomodeline  " https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set visualbell " disable bell

let maplocalleader="\\"

" plugin management {{{
" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" }}}
" timetracking {{{
Plug 'termoshtt/toggl.vim'
"let g:toggl_api_token = ""
"let g:toggl_workspace_id = 123
Plug 'wakatime/vim-wakatime'

" }}}
" colorschemes {{{
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'NLKNguyen/papercolor-theme' " PaperColor
" Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'
let g:airline_theme = 'codedark'

" }}}
" unsorted plugins {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = {'down':'40%'}
" copy of fzf's s:p
function! s:p(...)
  let preview_args = get(g:, 'fzf_preview_window', ['right', 'ctrl-/'])
  if empty(preview_args)
    return { 'options': ['--preview-window', 'hidden'] }
  endif

  " For backward-compatiblity
  if type(preview_args) == type('')
    let preview_args = [preview_args]
  endif
  return call('fzf#vim#with_preview', extend(copy(a:000), preview_args))
endfunction

Plug 'scy/vim-mkdir-on-write'
Plug 'vim-jp/vital.vim'
Plug 'mattn/webapi-vim'
Plug 'tpope/vim-speeddating'
Plug 'embear/vim-localvimrc'
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0

"Plug 'vim-scripts/DrawIt'

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
Plug 'ap/vim-css-color'
Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1
Plug 'terryma/vim-expand-region' " + -
Plug 'mattn/emmet-vim', { 'for': ['html', 'xml', 'vue', 'javascript', 'typescript']} " c-y,
Plug 'AndrewRadev/splitjoin.vim' " gS gJ
"Plugin 'kshenoy/vim-signature'
Plug 'mbbill/undotree'
nnoremap <leader>uu :UndotreeToggle<cr>
Plug 'Yggdroot/indentLine'
let g:indentLine_color_term = 236
let g:indentLine_char = '|'
set concealcursor=
autocmd FileType json :IndentLinesDisable
nnoremap <leader>ni :IndentLinesToggle<cr>
" }}}
" language server (c) {{{
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

nnoremap <leader>C :<c-u>CocDisable<cr>
nnoremap <leader>Cc :<c-u>CocEnable<cr>
nnoremap <leader>ci :<c-u>CocInstall 
nnoremap <leader>cl :<c-u>CocList<cr>
nnoremap <leader>cx :<c-u>CocAction<cr>

nnoremap <leader>ct :<c-u>call ToggleAutoTrigger()<cr>
nnoremap <leader>cF :<c-u>call ToggleAutoFix()<cr>
nmap <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>cs <Plug>(coc-fix-current)
nmap <silent> <leader>cf :CocFix<cr>
nmap <silent> <leader>cS <Plug>(coc-codeaction)
nmap <silent> <leader>ca <Plug>(coc-diagnostic-next)
nmap <silent> <leader>cA <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cg :call CocAction('doHover')<CR>
nmap <silent> <leader>cu <Plug>(coc-references)
nmap <silent> <leader>cp :call CocActionAsync('format')<CR>

function! ToggleAutoTrigger()
  if get(g:coc_user_config, 'suggest.autoTrigger') == 'always'
    call coc#config('suggest.autoTrigger', 'none')
  else
    call coc#config('suggest.autoTrigger', 'always')
  endif
endfunction

function! ToggleAutoFix()
  if get(g:coc_user_config, 'eslint.autoFixOnSave') == 'true'
    echo "no longer fixing on save"
    call coc#config('eslint.autoFixOnSave', 'false')
  else
    echo "fixing on save"
    call coc#config('eslint.autoFixOnSave', 'true')
  endif
endfunction

" Use K to show documentation in preview window, from coc
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-c> to trigger completion.
inoremap <silent><expr> <c-c> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" }}}
" note taking (n) {{{
Plug 'metakirby5/codi.vim'
" toggle scratchpad
nnoremap <leader>ns :Codi!!<cr>

Plug 'xolox/vim-misc'
Plug 'junegunn/goyo.vim'
nnoremap <leader>ng :Goyo<cr>:set linebreak!<cr>:IndentLinesToggle<cr>
"Plugin 'xolox/vim-notes'
Plug 'junegunn/limelight.vim'
Plug 'itchyny/calendar.vim'
Plug 'RRethy/vim-illuminate'
Plug 'vimwiki/vimwiki', { 'for': ['vimwiki', 'markdown']}
let g:Illuminate_delay = 1

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
Plug 'shime/vim-livedown', { 'for': ['vimwiki', 'markdown']}
au FileType markdown nnoremap <leader>nm :LivedownToggle<cr>
let g:livedown_browser = 'firefox'

function! UseBookMode()
    LivedownPreview
    Goyo
    IndentLinesDisable
    Limelight
    g:saving_at_every_edit = 0
    call ToggleSaveEveryEdit()
    set linebreak
    set wrap
    set spell
    nnoremap j gj
    nnoremap k gk
    " add a note
    let @i = '?note-index2f-lyt"a<a name="note-content-pyiwA" href="#note-index-pA"><sup>pA</sup></a>Go</p><a name="note-index-pA" href="#note-content-pA">pa</a>: </p>Bi'
endfunction
nnoremap <leader>nb :call UseBookMode()<cr>
" for books: \nm\ng\sns
" }}}
" text-object related {{{
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'

" 'someOb<cursor>ject' -> d,w -> 'some<cursor>'
Plug 'bkad/CamelCaseMotion'
omap <silent> ,w <Plug>CamelCaseMotion_iw
xmap <silent> ,w <Plug>CamelCaseMotion_iw
omap <silent> ,b <Plug>CamelCaseMotion_ib
xmap <silent> ,b <Plug>CamelCaseMotion_ib
omap <silent> ,e <Plug>CamelCaseMotion_ie
xmap <silent> ,e <Plug>CamelCaseMotion_ie

" cii / cai
Plug 'michaeljsmith/vim-indent-object'

" https://github.com/tpope/vim-abolish
" crs = to snake_case
" crc = to camelCase
" crm = to MixedCase
" cru = to UPPER_CASE
" cr- = to dash-case
" cr. = to space case
" crt = to Title Case
Plug 'tpope/vim-abolish'

" }}}
" git (g) {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
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
" gist (h) {{{
Plug 'mattn/gist-vim'

nnoremap <leader>hh <esc>:Gist -a<cr>
nnoremap <leader>hs <esc>:Gist -p<cr>
nnoremap <leader>hp <esc>:Gist -P<cr>
vnoremap <leader>hh <esc>:Gist -a<cr>
vnoremap <leader>hs <esc>:Gist -p<cr>
vnoremap <leader>hp <esc>:Gist -P<cr>

" }}}
" status line {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

" }}}
" autocomplete ? {{{
"Plug 'othree/jspc.vim', { 'for': ['javascript', 'typescript', 'html', 'vue']}
"Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'typescript', 'html', 'vue'], 'do': 'npm i' }
"setlocal ofu=syntaxcomplete#Complete
"set completeopt-=preview

"inoremap <c-c> <c-x><c-o>

" }}}
" c++ {{{
Plug 'vim-scripts/OmniCppComplete', { 'for': ['cpp', 'hpp']}
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
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'json': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'vue': ['eslint'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'h': ['clang-format'],
\   'hpp': ['clang-format'],
\   'rust': ['rustfmt'],
\   'python': ['autopep8'],
\   'reason': ['refmt'],
\   'ruby': ['rubocop']
\}
map <leader>f :ALEFix<CR>
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['eslint'],
\   'json': ['eslint'],
\   'typescript': ['eslint'],
\   'rust': ['rustc'],
\   'sql': ['sqlint'],
\   'reason': ['refmt'],
\}

" let g:ale_sign_error = '█'
" let g:ale_sign_warning = '█' " '𝄚'

" highlight ALEErrorSign ctermbg=none ctermfg=darkyellow
" highlight ALEWarningSign ctermbg=none ctermfg=darkyellow
highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline

map <Leader>af <Esc>:ALEFix<Enter>
map <Leader>an <Esc>:ALENext<Enter>
map <Leader>ad <Esc>:ALEDetail<Enter>

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
Plug 'mxw/vim-jsx', {'for':['javascript', 'jsx']}

" }}}
" angular {{{
"Plugin 'burnettk/vim-angular'

" }}}
" javascript {{{
Plug 'jelera/vim-javascript-syntax', {'for':['javascript', 'jsx', 'vue', 'html']}
Plug 'pangloss/vim-javascript', {'for':['javascript', 'jsx', 'vue', 'html']}
"Plug 'moll/vim-node', {'for':['javascript', 'jsx', 'vue', 'html']}
Plug 'Quramy/vim-js-pretty-template', {'for':['javascript', 'jsx', 'vue', 'html']}
augroup js-init
  au FileType javascript setlocal omnifunc=jspc#omni
  au FileType javascript nnoremap <buffer> <leader>rr :!node <c-r>=expand("%:p")<cr><cr>
augroup END

au FileType javascript,jsx,vue nnoremap <leader>ri :!npm install --save 
" }}}
" elm {{{

" using outdated system
"Plugin 'Zaptic/elm-vim'
"let g:elm_setup_keybindings = 0
""au FileType elm nnoremap <leader>rr <plug>(elm-make)
"au FileType elm nmap <leader>rb <plug>(elm-make)
"au FileType elm nmap <leader>rm <plug>(elm-make-main)
"au FileType elm nmap <leader>rt <plug>(elm-test)
"au FileType elm nmap <leader>re <plug>(elm-repl)
"au FileType elm nmap <leader>te <plug>(elm-error-details)
"au FileType elm nmap <leader>td <plug>(elm-show-docs)

" language server, remember to add to coc-settings.json
Plug 'andys8/vim-elm-syntax', { 'for': ['elm'] }

au FileType elm nnoremap <leader>ri :!elm install 
" }}}
" reason-ml {{{
Plug 'reasonml-editor/vim-reason-plus'
au FileType reason nnoremap <leader>rr :!node <c-r>=expand("%<:p")<cr>.bs.js<cr>
au FileType reason nnoremap <leader>rb :!bsb -make-world && node <c-r>=expand("%<:p")<cr>.bs.js<cr>
" }}}
" vue {{{
Plug 'posva/vim-vue', {'for':['javascript', 'jsx', 'vue', 'html']}

" format element. F<ea<cr><esc>f>i<cr><80><esc>. 80 is backspace
au FileType vue let @i = "F<eaf>i�kb"
" }}}
" typescript {{{
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
"Plug 'Quramy/tsuquyomi', {'for': 'typescript'}
"
"augroup ts-mappings
"  au FileType typescript map <buffer> <Leader>td <Esc>:TsuDefinition<Enter>
"  au FileType typescript map <buffer> <Leader>tt <Esc>:TsuTypeDefinition<Enter>
"  au FileType typescript map <buffer> <Leader>tr <Esc>:TsuReferences<Enter>
"  au FileType typescript map <buffer> <Leader>ti <Esc>:TsuImplementation<Enter>
"  au FileType typescript map <buffer> <Leader>ts <Esc>:TsuSearch<Enter>
"  au FileType typescript map <buffer> <Leader>tn <Esc>:TsuRenameSymbol<Enter>
"  au FileType typescript map <buffer> <Leader>tN <Esc>:TsuRenameSymbolC<Enter>
"  au FileType typescript map <buffer> <Leader>tI <Esc>:TsuImport<Enter>
"augroup END

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
Plug 'VelkyVenik/vim-avr' " always sets type to avr. Better fix it somehow
au FileType asm set ft=avr
au FileType avr set tabstop=8
au FileType avr set softtabstop=0 noexpandtab
au FileType avr set shiftwidth=8
" }}}
" python {{{
"Plug 'davidhalter/jedi-vim' " autocomplete
"let g:jedi#show_call_signatures = "1"
"let g:jedi#goto_command             = "<leader>td"
"let g:jedi#goto_assignments_command = ""
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command    = "K"
"let g:jedi#usages_command           = "<leader>tr"
"let g:jedi#completions_command      = "<C-Space>"
"let g:jedi#rename_command           = "<leader>tn"

"Plug 'tweekmonster/django-plus.vim'

au FileType python nnoremap <leader>rr :!python3 <c-r>=expand("%:p")<cr><cr>
au FileType python nnoremap <leader>rt :!pytest <c-r>=expand("%:p")<cr><cr>
au FileType python nnoremap <leader>ri :!pip install --user 
" }}}
" ruby {{{
au FileType ruby nnoremap <leader>rr :!ruby <c-r>=expand("%:p")<cr><cr>
" }}}
" Qt {{{
Plug 'peterhoeg/vim-qml'
au FileType qml nnoremap <buffer> <leader>rr :!qmlscene <c-r>=expand("%:p")<cr><cr>
au FileType qml nnoremap <buffer> <leader>rm :!QT_QUICK_CONTROLS_STYLE=material qmlscene <c-r>=expand("%:p")<cr><cr>
" }}}
" Ultisnips {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsSnippetDirectories=["/home/user/UltiSnips"]

let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}
" regex {{{
Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" }}}
" rust {{{
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
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
Plug 'scrooloose/nerdtree'

let g:NERDTreeWinSize=20

" }}}
" docker  {{{
Plug 'docker/docker'

" }}}
" sql {{{
"Plugin 'vim-scripts/sql.vim'
" }}}
" r {{{
" run, and allow to look at term
au FileType r nnoremap <buffer> <leader>re :!echo "x11();" > /tmp/vim-r-script && cat <c-r>=expand("%:p")<cr> >> /tmp/vim-r-script && echo "Sys.sleep(.05);system('x-terminal-emulator --title \"Floater Confirm\" -d 5 5 -e bash -c read')" >> /tmp/vim-r-script && Rscript /tmp/vim-r-script && rm /tmp/vim-r-script<cr>
" run, and go back to code
au FileType r nnoremap <buffer> <leader>rr :!echo "x11();" > /tmp/vim-r-script && cat <c-r>=expand("%:p")<cr> >> /tmp/vim-r-script && echo "Sys.sleep(.05);system('x-terminal-emulator --title \"Floater Confirm\" -d 5 5 -e bash -c read')" >> /tmp/vim-r-script && Rscript /tmp/vim-r-script && rm /tmp/vim-r-script<cr><cr>
au FileType r nnoremap <buffer> <leader>rt :!Rscript <c-r>=expand("%:p")<cr><cr>
" }}}
" php {{{
au FileType php nnoremap <buffer> <leader>rr :!php <c-r>=expand("%:p")<cr><cr>
" }}}
" authoring vim plugins {{{
Plug 'tpope/vim-scriptease'

" }}}
" end plugin management {{{
call plug#end()
filetype plugin indent on

autocmd vimenter * ++nested colorscheme codedark

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
let $MYVIMRC = "~/.vimrc"
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
" leader plugin (p) {{{
nnoremap <leader>pi <esc>:w<cr>:source ~/.vimrc<cr>:PlugInstall<cr>
nnoremap <leader>pc <esc>:w<cr>:source ~/.vimrc<cr>:PlugClean<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>ps :PlugStatus<cr>
nnoremap <leader>pd :PlugDiff<cr>
" upgrade vim-plug itself
nnoremap <leader>pU :PlugUpgrade<cr>
" }}}
" leader insert (i) {{{
nnoremap <leader>id :let @d=strftime("%c")<cr>"dP
nnoremap <leader>iD :pu=strftime('%c')<cr>
" }}}
" leader opening (o) {{{
" open current file in a new tab
nnoremap <leader>oo :tabe %<cr><c-o>zz
nnoremap <c-t> :tabe %<cr><c-o>zz
" open terminal
nnoremap <leader>ot :term zsh<cr>
" toggle nerdtree
nnoremap <leader>on :NERDTreeToggle<cr>
nnoremap <leader>of :NERDTreeFind<cr>

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

function! ToggleColorColumn()
  if strlen(&colorcolumn) == 0
    set colorcolumn=80
  else
    set colorcolumn=
  endif
endfunction
nnoremap <leader>sc :call ToggleColorColumn()<cr>

nnoremap <leader>sts :let old_ft=&filetype <bar> set ft=txt<cr>
nnoremap <leader>str :let &ft=old_ft<cr>

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
  \ call fzf#vim#files(<q-args>, 
  \   s:p({'source': 'ag --hidden --ignore .git -g ""'}), <bang>0)
nnoremap <leader>zx :HFiles<cr>
command! -bang -nargs=? -complete=dir HNGFiles
  \ call fzf#vim#files(<q-args>,
  \   s:p({'source': 'ag --hidden --skip-vcs-ignores --ignore .git -g ""'}), <bang>0)
nnoremap <leader>zX :HNGFiles<cr>
nnoremap <leader>zf :Locate *<cr>

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
command! -bang -nargs=* CAg call fzf#vim#ag(<q-args>, s:p({'options': 
      \   ['--delimiter=:', '--nth=4..']}), <bang>0)
nnoremap <leader>zv :CAg<cr>
vnoremap <leader>zv :<c-u>CAg <c-r>*<cr>
" c-_ is really c-/
nnoremap <c-_> :CAg<cr>
nnoremap <leader>zV :Ag<cr>

nnoremap <leader>zm :Marks<cr>
" file history
nnoremap <leader>zh :History<cr>
" command history
nnoremap <leader>z: :History:<cr>
" search history
nnoremap <leader>z/ :History/<cr>
" go to 'TODO CONTINUE FROM HERE'
nnoremap <leader>zk :CAg TODO CONTINUE FROM HERE<cr>

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
" leader copy to clipboard (y) {{{
nnoremap <leader>yg gg"+yG<c-o><c-o>
nnoremap <leader>yb "+yi{<c-o>
nnoremap <leader>yf [[j"+yi{<c-o><c-o>
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
" }}}

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
