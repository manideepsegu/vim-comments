if exists("g:vim_comments")
  finish
endif
let g:vim_comments = 1
let s:escape_chars = '\\/.*$^~[]&'
function! s:MarkTodo(str) abort
  let line = escape(getline('.'), s:escape_chars)
  if line !~ '^\s*$'
    call setline('.', substitute(line, '^.*$', escape(substitute(&commentstring, '%s', a:str . line . ' ', ''), s:escape_chars), ''))
  endif
endfunction
function! s:UnMarkTodo(str) abort
  let line = getline('.')
  let submatches = matchlist(line, substitute("^" . escape(&commentstring, s:escape_chars) . "$", '%s', a:str . '\\(.*\\)\\s*', ''))
  if !empty(submatches)
    call setline('.', submatches[1])
  endif
endfunction

xnoremap <silent> ,m :call <sid>MarkTodo(' ')<CR>
xnoremap <silent> ,n :call <sid>UnMarkTodo(' ')<CR> 
nnoremap <silent> ,m :call <sid>MarkTodo(' ')<CR>
nnoremap <silent> ,n :call <sid>UnMarkTodo(' ')<CR>

xnoremap <silent> ,mm :call <sid>MarkTodo(printf(' TODO REVIEW:%0s ', toupper($USER)))<CR>
xnoremap <silent> ,nn :call <sid>UnMarkTodo(printf(' TODO REVIEW:%0s ', toupper($USER)))<CR>
nnoremap <silent> ,mm :call <sid>MarkTodo(printf(' TODO REVIEW:%0s ', toupper($USER)))<CR>
nnoremap <silent> ,nn :call <sid>UnMarkTodo(printf(' TODO REVIEW:%0s ', toupper($USER)))<CR>
