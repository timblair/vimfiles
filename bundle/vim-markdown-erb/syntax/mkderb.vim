" Vim syntax file
" Language:    Markdown with embedded ERB
" Maintainer:  Tim Blair <tim@bla.ir>

" Read the Markdown syntax to start with
if version < 600
  so <sfile>:p:h/mkd.vim
else
  runtime! syntax/mkd.vim
  unlet b:current_syntax
endif

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Put the ruby syntax file in @rubyTop
syn include @rubyTop syntax/ruby.vim

syn region erubyBlock matchgroup=erubyRubyDelim start=#<%=\?# end=#%># keepend containedin=ALL contains=@rubyTop,erubyEnd
syn region erubyComment start=+<%#+ end=#%># keepend
syn match erubyEnd #\<end\>#

hi link erubyRubyDelim todo
hi link erubyComment comment
hi link erubyEnd rubyControl
