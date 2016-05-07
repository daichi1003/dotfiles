"---------------
"Bundle Scripts
"---------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
"" Add NERDtree
NeoBundle 'scrooloose/nerdtree'
"" Add color-scheme-solarized
NeoBundle 'altercation/vim-colors-solarized'
"" Add Unite.vim
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"---------------------
"End NeoBundle Scripts
"---------------------

