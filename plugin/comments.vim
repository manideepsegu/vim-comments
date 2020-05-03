if exists("g:vim_comments")
  finish
endif
let g:vim_comments = 1
function! s:MarkTodo(str) abort
  let line = escape(getline('.'), '\\/.*$^~[]&')
  if line !~ '^\s*$'
    call setline('.', substitute(line, '^.*$', escape(substitute(&commentstring, '%s', a:str . line . ' ', ''), '\\/.*$^~[]&'), ''))
  endif
endfunction
function! s:UnMarkTodo(str) abort
  let line = getline('.')
  let submatches = matchlist(line, substitute("^" . &commentstring . "$", '%s', a:str . '\\(.*\\) ', ''))
  if !empty(submatches)
    call setline('.', submatches[1])
  endif
endfunction

xnoremap <silent> ,m :call <sid>MarkTodo(' ')<CR>
xnoremap <silent> ,n :call <sid>UnMarkTodo(' ')<CR>
nnoremap <silent> ,m :call <sid>MarkTodo(' ')<CR>
nnoremap <silent> ,n :call <sid>UnMarkTodo(' ')<CR>

xnoremap <silent> ,mm :call <sid>MarkTodo(' TODO REVIEW:MS ')<CR>
xnoremap <silent> ,nn :call <sid>UnMarkTodo(' TODO REVIEW:MS ')<CR>
nnoremap <silent> ,mm :call <sid>MarkTodo(' TODO REVIEW:MS ')<CR>
nnoremap <silent> ,nn :call <sid>UnMarkTodo(' TODO REVIEW:MS ')<CR>
