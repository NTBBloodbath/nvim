" Copyright (c) 2021 DanSnow
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetNasmIndent(v:lnum)
setlocal indentkeys+=<:>

if exists("*GetNasmIndent")
  finish
endif

function! s:get_prev_non_comment_line_num(line_num)
  let SKIP_LINES = '^\s*;.*'
  let nline = a:line_num
  while nline > 0
    let nline = prevnonblank(nline - 1)
    if getline(nline) !~? SKIP_LINES
      break
    endif
  endwhile
  return nline
endfunction

function! GetNasmIndent(lnum)
  if a:lnum == 0
    return 0
  endif
  let this_line = getline(a:lnum)
  let prev_code_num = s:get_prev_non_comment_line_num(a:lnum)
  let prev_code = getline(prev_code_num)
  let indnt = indent(prev_code_num)
  if this_line =~ '^\s;'
    return indent(a:lnum)
  endif
  if this_line =~ '^\s*.*:'
    return 0
  endif
  if this_line =~ '\v.*d(b|w|d)'
    return 0
  endif
  if prev_code =~ '.*:'
    return indnt + &shiftwidth
  endif
  return indnt
endfunction
