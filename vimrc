set nocompatible
set sw=2
set ts=2
set softtabstop=2
set tw=80
set cc=81
set vb t_vb=""
set incsearch
set hlsearch
set ignorecase
set smartcase
set ruler
set wildmenu
set wildignore=*.o

syntax on
filetype on
filetype indent on
filetype plugin on
compiler ruby
set ofu=syntaxcomplete#Complete

set expandtab
set autoindent

"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1

set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=L
"map <C-L> <Esc>:!ruby %<CR>

"set guifont=Menlo\ Regular:h11
set guifont=Andale\ Mono:h13

"set TlistOpen
colo darkZ "molokai

:vsp

let Tlist_Auto_Open = 1
let Tlist_Display_Tag_Scope = 0
let Tlist_Exit_OnlyWindow = 1
:ab #DEBUG# require 'rubygems'; require 'ruby-debug/debugger' 

augroup ruby
  set omnifunc=rubycomplete#Complete
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_rails = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_include_object = 1
  let g:rubycomplete_include_objectspace = 1
augroup END

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

