let g:python3_host_prog='/Users/near129/.pyenv/shims/python'
if &compatible
  set nocompatible
endif
language message C
filetype plugin indent on
syntax enable
syntax on
 " Load dein.
let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein')
          \. '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
" set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
endif
runtime! ./dein.rc.vim
runtime! ./options.rc.vim
runtime! ./mappings.rc.vim
" runtime! ./atcoder.rc.vim

 