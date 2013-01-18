execute pathogen#infect()

colorscheme solarized
set background=dark
call togglebg#map("<F5>")

" visual indicator to keep lines short
if exists('+colorcolumn')
  " highlight the 80th column (only in 7.3+)
  set colorcolumn=80
else
  " highlight any text that goes over 80 characters
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" One less key-press for entering colon-command mode
nmap <Space> :
vmap <Space> :

" various GUI options
set guioptions-=T " remove the toolbar
set guifont=Source_Code_Pro:h10
set linespace=-1

" shortcut to show invisibles (tabs, carriage returns)
nmap <leader>i :set list!<CR>
set list
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Alternate way to switch to the buffer you just left (rahter than <C-6> which
" is helpfully yoinked by OSX's Spaces when you have that many spaces open...
map <C-a> :b#<CR>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Block wrap
map <C-w> gwap

" quickly move around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
