 set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'


" In your .vimrc.bundles.local file"
" list only the plugin groups you will use
if !exists('g:brooky_bundle_groups')
    let g:brooky_bundle_groups=['general', 'programming', 'php', 'python', 'twig', 'javascript', 'html']
endif


 " My Bundles here:
 " original repos on github
 
"--------------------
" general 
"--------------------
 Bundle 'altercation/vim-colors-solarized'
 Bundle 'mileszs/ack.vim'
 Bundle 'Townk/vim-autoclose.git'
 Bundle 'tpope/vim-surround.git'
 " Bundle 'Twinside/vim-cuteErrorMarker.git'
 Bundle 'vim-scripts/YankRing.vim.git'
 Bundle 'vim-scripts/VisIncr.git'
 Bundle 'sukima/xmledit.git'
 Bundle 'vim-scripts/matchit.zip.git'
 Bundle 'scrooloose/nerdtree.git'
 Bundle 'jistr/vim-nerdtree-tabs'
 Bundle 'Lokaltog/vim-easymotion.git'
 Bundle 'vim-scripts/pythoncomplete.git'
 Bundle 'Lokaltog/vim-powerline.git'
 Bundle 'mbbill/undotree'
 Bundle 'airblade/vim-gitgutter'
 Bundle 'kien/ctrlp.vim'
 Bundle 'danro/rename.vim'
 Bundle 'vim-scripts/indent-motion'
 " Bundle 'Valloric/YouCompleteMe'

"--------------------
" general programming
"--------------------
 Bundle 'tpope/vim-fugitive'
 Bundle 'editorconfig/editorconfig-vim'

 " syntac checking for lots of languages
 " Bundle "scrooloose/syntastic"
 Bundle 'scrooloose/nerdcommenter.git'
 Bundle 'godlygeek/tabular'
 Bundle 'majutsushi/tagbar'
 
 " visually displaying indent levels
 Bundle "nathanaelkane/vim-indent-guides"
 
"--------------------
" Snippets & AutoComplete
"--------------------
 Bundle 'SirVer/ultisnips'
 Bundle 'honza/vim-snippets'


"--------------------
" for php
"--------------------
 " following php coding standard PSR-1 and PSR-2 documents.
 Bundle 'stephpy/vim-php-cs-fixer'
 " Bundle 'spf13/PIV'
 Bundle 'vim-scripts/PDV--phpDocumentor-for-Vim.git'
 Bundle 'arnaud-lb/vim-php-namespace'
 Bundle 'brookhong/DBGPavim.git'
 " Bundle 'shawncplus/phpcomplete.vim'
 

"--------------------
" for javascript
"--------------------
 Bundle 'elzr/vim-json'
 Bundle 'pangloss/vim-javascript.git'
 Bundle 'hallettj/jslint.vim'
 Bundle 'kchmck/vim-coffee-script'


"--------------------
" twig
"--------------------
 Bundle 'evidens/vim-twig'

 " non github repos
 " Bundle 'git://git.wincent.com/command-t.git'

"--------------------
" markdown
"--------------------
Bundle 'plasticboy/vim-markdown'

"--------------------
" jade
"--------------------
Bundle 'digitaltoad/vim-jade'


 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..
 source ~/.vim/brooky.vimrc
