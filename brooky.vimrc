" brooky's vimrc

" General Settings

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside
set nu      		" show line numbers


filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


syntax on		" syntax highlight
set hlsearch		" search highlighting

if has("gui_running")	" GUI color and font settings
  set guifont=Osaka-Mono:h20
  set background=dark
  set t_Co=256          " 256 color mode
  set cursorline        " highlight current line
  colors moria
  highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
else
" terminal color settings
  colors vgod
endif

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
set incsearch		" incremental search
set backup              " save backup files
set backupdir=~/.vim/backup/ " where to put backup file
set dir=~/.vim/tmp      " tell vim where to put swap files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting{
   set expandtab        "replace <TAB> with spaces
   set softtabstop=4
   set shiftwidth=4

   au FileType Makefile set noexpandtab
"}

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}


" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" Tip #382: Search for <cword> and replace with input() in all open buffers
"---------------------------------------------------------------------------
fun! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
    :unlet! s:word
endfun


"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------
" set leader to ,
let mapleader=","
let g:mapleader=","

" quick alias to leave vim
nmap <leader>w :x<CR>
nmap <leader>q :q!<CR>

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" open the error console
map <leader>er :botright cope<CR>
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" --- move around splits {
    " move between two windows
    map <C-W> <C-W><C-W>
    " move to and maximize the below split
    map <C-J> <C-W>j<C-W>_
    " move to and maximize the above split
    map <C-K> <C-W>k<C-W>_
    " move to and maximize the left split
    nmap <c-h> <c-w>h<c-w><bar>
    " move to and maximize the right split
    nmap <c-l> <c-w>l<c-w><bar>
    set wmw=0                     " set the min width of a window to 0 so we can maximize others
    set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab
" map <S-H> gT
" go to next tab
" map <S-L> gt

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR>

" ,/ turn off search highlighting
nmap <leader>/ :set hls!<CR>
" noremap <F4> :set hls!<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Writing Restructured Text (Sphinx Documentation) {
   " Ctrl-u 1:    underline Parts w/ #'s
   noremap  <C-u>1 yyPVr#yyjp
   inoremap <C-u>1 <esc>yyPVr#yyjpA
   " Ctrl-u 2:    underline Chapters w/ *'s
   noremap  <C-u>2 yyPVr*yyjp
   inoremap <C-u>2 <esc>yyPVr*yyjpA
   " Ctrl-u 3:    underline Section Level 1 w/ ='s
   noremap  <C-u>3 yypVr=
   inoremap <C-u>3 <esc>yypVr=A
   " Ctrl-u 4:    underline Section Level 2 w/ -'s
   noremap  <C-u>4 yypVr-
   inoremap <C-u>4 <esc>yypVr-A
   " Ctrl-u 5:    underline Section Level 3 w/ ^'s
   noremap  <C-u>5 yypVr^
   inoremap <C-u>5 <esc>yypVr^A
"}

"---------------------------------------------------------------------------
" PROGRAMMING SHORTCUTS
"---------------------------------------------------------------------------

" working with tag + tab {
    " Ctrl-[ jump out of the tag stack (undo Ctrl-])
    " map <C-[> <ESC>:po<CR>
    " open tag in new tab
    nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
" }

" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun



" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \	if &omnifunc == "" |
              \		setlocal omnifunc=syntaxcomplete#Complete |
              \	endif
endif

set cot-=preview "disable doc preview in omnicomplete

" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css

" map .tpl (smarty template) to html
autocmd BufNewFile,BufRead *.tpl              set ft=html

"---------------------------------------------
" for PHP programming
"---------------------------------------------
autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l


"---------------------------------------------
" for edit CSS
"---------------------------------------------
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

"---------------------------------------------
" for edit HTML
"---------------------------------------------
autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType haml setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4


"---------------------------------------------
" file type detection
"---------------------------------------------
" highlight action script and mxml syntax
au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript
au BufNewFile,BufRead *.less set filetype=less


"---------------------------------------------
" for coloring
"---------------------------------------------
" 以下是顏色設定，詳細請 :h hi
" colorscheme ir_black
hi Comment      term=bold ctermfg=darkcyan
hi Constant     term=underline ctermfg=Red
hi Special      term=bold ctermfg=Magenta
hi Identifier   term=underline ctermfg=cyan
hi Statement    term=bold ctermfg=Brown
hi PreProc      term=bold ctermfg=DarkYellow
hi Type         term=bold ctermfg=DarkGreen
hi Ignore       ctermfg=white
hi Error        term=reverse ctermbg=Red ctermfg=White
hi Todo         term=standout ctermbg=Yellow ctermfg=Red
hi Search       term=standout ctermbg=Yellow ctermfg=Black
hi ErrorMsg     term=reverse ctermbg=Red ctermfg=White
hi StatusLine   ctermfg=darkblue  ctermbg=gray
hi StatusLineNC ctermfg=brown   ctermbg=darkblue


"---------------------------------------------
" set GUI scheme and font for gVim
"---------------------------------------------
colorscheme koehler
" set guifont=monospace\ 12


"---------------------------------------------
" use w!! to write protected files
"---------------------------------------------
cmap w!! %!sudo tee > /dev/null %


"---------------------------------------------
" copy to system buffer
"---------------------------------------------
vnoremap <C-S-C> "+y<CR>
map <C-S-c>  "+y<CR>
map <C-S-v> "+p<CR>


"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
	set encoding=utf-8
	set termencoding=big5
endfun

fun! UTF8()
	set encoding=utf-8
	set termencoding=big5
	set fileencoding=utf-8
	set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
	set encoding=big5
	set fileencoding=big5
endfun



"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------
" Plugins {

    " PIV {
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }

    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
    " }

    " AutoClose {
        " Inserts matching bracket, paren, brace or quote  {
        " fixed the arrow key problems caused by AutoClose
        if !has("gui_running")
           set term=linux
           imap OA <ESC>ki
           imap OB <ESC>ji
           imap OC <ESC>li
           imap OD <ESC>hi

           nmap OA k
           nmap OB j
           nmap OC l
           nmap OD h
        endif
    " }


    " SuperTab {
        let g:SuperTabDefaultCompletionType = "context"
    " }

    " Ctrl-P {
        "--------------------
        " setting for Ctrl-P
        " 0 - don't follow symbolic links.
        " 1 - follow but ignore looped internal symlinks to avoid duplicates.
        " 2 - follow all symlinks indiscriminately.
        "--------------------
        let g:ctrlp_follow_symlinks = 0
        let g:ctrlp_working_path_mode = 'ra'
        " nnoremap <silent> <D-t> :CtrlP<CR>
        " nnoremap <silent> <D-r> :CtrlPMRU<CR>
        nmap <Leader>f :CtrlPClearCache<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f'
        \ }

    " }

    " EasyMotion {
        let g:EasyMotion_leader_key = '<Leader><Leader>' " default is <Leader>w
        hi link EasyMotionTarget ErrorMsg
        hi link EasyMotionShade  Comment
    " }

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }


    " indent_guides {
        if !exists('g:spf13_no_indent_guides_autocolor')
            let g:indent_guides_auto_colors = 1
        else
            " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
        endif
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }

    " Ultisnips {
        let g:UltiSnipsExpandTrigger = "<c-j>"
        " let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
    " }

    " Tabularize {
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
        nnoremap <silent> <leader>gg :GitGutterToggle<CR>
    "}

    " TagBar {
        nmap <silent> <Leader>t :TagbarToggle<CR>

        " If using go please install the gotags program using the following
        " go install github.com/jstemmer/gotags
        " And make sure gotags is in your path
        let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
                \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
                \ 'r:constructor', 'f:functions' ],
            \ 'sro' : '.',
            \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
            \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }

        " toggle TagBar with F7
        " nnoremap <silent> <F7> :TagbarToggle<CR>
        " set focus to TagBar when opening it
        let g:tagbar_autofocus = 1
    "}

    " PowerLine {
        " let g:Powerline_symbols = 'fancy' " require fontpatcher
    " }

    " NERDTree {
        " nnoremap <silent> <F3> :NERDTree<CR>
        nmap <Leader>n :NERDTreeToggle<CR>
        nmap <Leader>nm :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        nmap <Leader>ne :NERDTreeFind<CR>

        " map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        "map <leader>e :NERDTreeFind<CR>
        " nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=0
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " vim-nerdtree-tabs {
        let g:nerdtree_tabs_open_on_gui_startup=0
        let g:nerdtree_tabs_open_on_new_tab=1
        let g:nerdtree_tabs_open_on_console_startup=1
    " }

"---------------------------------------------
" using ctags
"---------------------------------------------
set tags=tags;          " 使用 tags 這個檔案 for jump between code


"---------------------------------------------
" shorcut for ctags
" learn from
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
"---------------------------------------------
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


"--------------------
" For YankRing.vim
" http://www.vim.org/scripts/script.php?script_id=1234
"--------------------
nnoremap <silent> <leader>y :YRShow<CR>


"--------------------
" For JavaScriptLint
" Ref: http://panweizeng.com/write-javascript-in-vim.html
"--------------------
"设置javascriptlint
autocmd FileType javascript set makeprg=~/bin/jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ ~/bin/jsl.default.conf\ -process\ %
autocmd FileType javascript set errorformat=%f(%l):\ %m
" autocmd FileType javascript inoremap <silent> <F9> <C-O>:make<CR>
" autocmd FileType javascript map <silent> <F9> :make<CR>


"--------------------
" For phpDocumentor (pdv)
" Ref: https://github.com/vim-scripts/PDV--phpDocumentor-for-Vim
"--------------------
inoremap <leader>pd <ESC>:call PhpDocSingle()<CR>i
nnoremap <leader>pd :call PhpDocSingle()<CR>
vnoremap <leader>pd :call PhpDocRange()<CR>

"--------------------
" fix bug: something breaks the syntax on
"--------------------
syntax on

"--------------------
" auto build php after saving files
"--------------------
" autocmd BufWritePost *.php make %
" autocmd BufWritePost *.php cwindow


"--------------------
" auto load vimrc whenever it is edited
"--------------------
" au! BufWritePost .vimrc source $MYVIMRC


"--------------------
" insert php namespace
"--------------------
inoremap <leader><Leader>u <ESC>:call PhpInsertUse()<CR>
nnoremap <leader><Leader>u :call PhpInsertUse()<CR>
vnoremap <leader><Leader>u :call PhpInsertUse()<CR>


"--------------------
" for using php-cs-fixer
"--------------------
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>


"--------------------
" Auto compile .haml files on save, but only
" if there's a .autocompilehaml file in the cwd.
" Depends on a `haml` executable. `sudo gem install haml`
"--------------------
au BufWritePost *.haml call HamlMake()

function! HamlMake()
    py << ENDOFPYTHON
import os
import vim

in_file = vim.current.buffer.name
dirname = os.path.dirname(in_file)
if os.path.exists(dirname + "/.autohaml"):
    out_file = in_file[0:-5] + ".html"
    os.system("haml %s > %s" % (in_file, out_file))

ENDOFPYTHON
endfunction


"--------------------
"Markdown to HTML
"--------------------
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>


"--------------------
" setting for zen coding
"--------------------
imap <leader>z <C-y>,

"--------------------
" visual mode search
" from: http://vim.wikia.com/wiki/Search_only_over_a_visual_range
"--------------------
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

"--------------------
" youcompeleteme
"--------------------
let g:ycm_filetype_specific_completion_to_disable = {"php":1}

"--------------------
" syntastic
"--------------------
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_warnings=1


"--------------------
" function for Move current window between tabs  Edit    Talk0
" http://vim.wikia.com/wiki/Move_current_window_between_tabs
"--------------------
function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

