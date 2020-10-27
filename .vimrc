""" 表示関係
set t_co=256
set background=dark
" colorscheme hybrid
syntax on
colorscheme iceberg
" set list                " 不可視文字の可視化
set number              " 行番号の表示
set ruler               " カーソル位置が右下に表示される
set wildmenu            " コマンドライン補完が強力になる
set showcmd             " コマンドを画面の最下部に表示する
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
" set colorcolumn=80      " その代わり80文字目にラインを入れる
set cursorline      " その代わり80文字目にラインを入れる
" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell
set foldmethod=indent    " 折り畳み
set foldlevel=100    " ファイルを開くときに折り畳みをしない

""" 編集関係
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set autoindent          " 改行時にインデントを引き継いで改行する
set shiftwidth=4        " インデントにつかわれる空白の数
au bufnewfile,bufread *.yml set shiftwidth=2
set softtabstop=4       " <tab>押下時の空白数
set expandtab           " <tab>押下時に<tab>ではなく、ホワイトスペースを挿入する
set tabstop=4           " <tab>が対応する空白の数
au bufnewfile,bufread *.yml set tabstop=2
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set nf=                 " インクリメント、デクリメントを10進数にする
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
" クリップボードをデフォルトのレジスタとして指定。後にyankringを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed
else
    set clipboard& clipboard+=unnamed
endif
" swapファイル, backupファイルを全て無効化する
set nowritebackup
set nobackup
set noswapfile

""" 検索関係
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト

inoremap <silent> jj <ESC>
inoremap <silent> <C-d> <C-g>u<Del>
nnoremap <ESC><ESC> :noh<CR>
nnoremap <C-p> :<C-u>bp<CR>
nnoremap <C-n> :<C-u>bn<CR>

" コマンドライン はemacs
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
" ターミナルでノーマルモードにctrl-[でいけるようにする
nnoremap <Leader>w <C-w>w
nnoremap > >>
nnoremap < <<
" Easily edit .vimrc
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>

if exists(':tnoremap')
  tnoremap   <ESC>      <C-\><C-n>
  tnoremap   jj         <C-\><C-n>
  tnoremap   j<Space>   j
  tnoremap <expr> ;  vimrc#sticky_func()
endif
