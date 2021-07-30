let g:mapleader = "\<Space>"
inoremap <silent> jj <ESC>
inoremap <silent> <C-d> <C-g>u<Del>
nnoremap <ESC><ESC> :noh<CR>
nnoremap <C-p> :<C-u>bp<CR>
nnoremap <C-n> :<C-u>bn<CR>

inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
" コマンドライン はemacs
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
" ターミナルでノーマルモードにctrl-[でいけるようにする
" nnoremap <Leader>w <C-w>w
nnoremap > >>
nnoremap < <<
" Easily edit .vimrc
" nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>

if exists(':tnoremap')
  tnoremap   <ESC>      <C-\><C-n>
  tnoremap   jj         <C-\><C-n>
  tnoremap   j<Space>   j
  tnoremap <expr> ;  vimrc#sticky_func()
endif
