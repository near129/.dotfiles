" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  execute 'source' . data_dir . '/autoload/plug.vim'
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'tpope/vim-commentary'
if exists('g:vscode')
    " VSCode extension
    Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
else
    " ordinary neovim
    Plug 'cocopon/iceberg.vim'
    Plug 'vim-scripts/vim-auto-save'
    Plug 'itchyny/lightline.vim'
    Plug 'Yggdroot/indentline'
    Plug 'easymotion/vim-easymotion'
    if has('nvim')
      Plug 'hrsh7th/cmp-buffer'
      Plug 'hrsh7th/cmp-cmdline'
      Plug 'hrsh7th/cmp-path'
      Plug 'hrsh7th/nvim-cmp'
    endif
endif
call plug#end()

let g:mapleader = "\<Space>"
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Leader> <Plug>(easymotion-s)
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
    colorscheme iceberg
    let g:auto_save = 1  " enable AutoSave on Vim startup
    let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
    let g:auto_save_silent = 1  " do not display the auto-save notification
    let g:lightline = {'colorscheme': 'iceberg'}
    if has('nvim')
      set completeopt=menu,menuone,noselect
lua << EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'path' },
    { name = 'buffer' },

  }
}
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
EOF
    endif
endif

runtime! ./options.rc.vim
runtime! ./mappings.rc.vim
