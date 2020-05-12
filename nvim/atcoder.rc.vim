" *******************************************************
" AtCoder
" *******************************************************
let g:atcoder_contest_dir = $HOME . '/AtCoder/'
function! AtCoderContest(contest)
    if !isdirectory(g:atcoder_contest_dir . a:contest)
        call mkdir(g:atcoder_contest_dir . a:contest)
        execute 'T' 'ojac' a:contest
       execute 'sleep' '3'
    endif
    execute 'lcd' '~/AtCoder/'.a:contest
    execute 'Denite' 'problem_file'
endfunction

command! -nargs=+ AtCoderContest :call AtCoderContest(<f-args>)

nnoremap <Leader>a :<C-u>AtCoderContest 
nnoremap <Leader>c :<C-u>T g++ % -o %:p:h/a.out<CR>
nnoremap <Leader>t :<C-u>T t %:p:h<CR>
nnoremap <Leader>s :<C-u>T s %:p:h<CR>
nnoremap <Leader><silent>ss :<C-u>T ss %:p:h<CR>
nnoremap <Leader><silent>sp :<C-u>T sp %:p:h<CR>

au BufEnter ~/AtCoder/*/main.py lcd %:h:h
au VimEnter ~/AtCoder 20sp Tnew | winc w | 

