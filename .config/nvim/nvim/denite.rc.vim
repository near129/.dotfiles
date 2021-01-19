"---------------------------------------------------------------------------
" denite.nvim
"

if executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep,line/external', {
        \ 'command': ['rg', '--threads', '1'],
        \ 'recursive_opts': [],
        \ 'final_opts': [],
        \ 'separator': ['--'],
        \ 'default_opts': ['-i', '--vimgrep', '--no-heading'],
        \ })
else
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

call denite#custom#source('file/old', 'matchers', [
      \ 'matcher/fruzzy', 'matcher/project_files', 'matcher/ignore_globs',
      \ ])
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
call denite#custom#source('file/rec', 'matchers',
      \ ['matcher/fruzzy'])
call denite#custom#source('file/old,ghq', 'converters',
      \ ['converter/relative_word', 'converter/relative_abbr'])

call denite#custom#alias('source', 'problem_file', 'file/rec')
call denite#custom#var('problem_file', 'command',
      \ ['rg' , '-g', 'main.py', '--files'])
cal denite#custom#source('problem_file', 'sorter/word')

"call denite#custom#alias('source', 'file/git', 'file/rec')
"call denite#custom#var('file/git', 'command',
"      \ ['git', 'ls-files', '-co', '--exclude-standard'])

"call denite#custom#alias('source', 'file/dirty', 'file/rec')
"call denite#custom#var('file/dirty', 'command',
"      \ ['git', 'ls-files', '-mo',
"      \  '--directory', '--no-empty-directory', '--exclude-standard'])

" call denite#custom#option('default', 'prompt', '>')
" call denite#custom#option('default', 'short_source_names', v:true)
if has('nvim')
  call denite#custom#option('default', {
        \ 'highlight_filter_background': 'CursorLine',
        \ 'source_names': 'short',
        \ 'split': 'floating',
        \ 'filter_split_direction': 'floating',
        \ 'vertical_preview': v:true,
        \ 'floating_preview': v:true,
        \ })
  call denite#custom#option('search', {
        \ 'highlight_filter_background': 'CursorLine',
        \ 'source_names': 'short',
        \ 'split': 'floating',
        \ 'filter_split_direction': 'floating',
        \ 'vertical_preview': v:true,
        \ 'floating_preview': v:true,
        \ })
else
  call denite#custom#option('default', {
        \ 'highlight_filter_background': 'CursorLine',
        \ 'source_names': 'short',
        \ 'vertical_preview': v:true,
        \ })
endif
call denite#custom#option('search', {
      \ 'highlight_filter_background': 'CursorLine',
      \ 'source_names': 'short',
      \ 'filter_split_direction': 'floating',
      \ })

let s:menus = {}
let s:menus.config = {
    \ 'description': 'config',
    \ }
let s:menus.config.file_candidates = [
    \ ['    > Edit configuation file (init.vim)', '~/.config/nvim/init.vim'],
    \ ['    > Edit configuation file (atcoder.rc.vim)', '~/.config/nvim/atcoder.rc.vim'],
    \ ['    > Edit configuation file (dein.rc.vim)', '~/.config/nvim/dein.rc.vim'],
    \ ['    > Edit configuation file (mappings.rc.vim)', '~/.config/nvim/mappings.rc.vim'],
    \ ['    > Edit configuation file (denite.rc.vim)', '~/.config/nvim/denite.rc.vim'],
    \ ['    > Edit configuation file (dein.toml)', '~/.config/nvim/dein.toml'],
    \ ['    > Edit configuation file (deinft.toml)', '~/.config/nvim/deinft.toml'],
    \ ['    > Edit configuation file (deinlazy.toml)', '~/.config/nvim/deinlazy.toml'],
    \ ]
call denite#custom#var('menu', 'menus', s:menus)

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
