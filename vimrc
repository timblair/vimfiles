execute pathogen#infect()

set tabstop=4
set shiftwidth=4
set cursorline
set nowrap
set visualbell
set number

let g:solarized_termcolors=256
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

" Easier shortcuts for jumping to beginning/end of line
map H ^
map L $

" One less key-press for entering colon-command mode
nmap <Space> :
vmap <Space> :

" shortcuts for opening files relative to the current open file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" status line settings
set laststatus=2
set statusline=
set statusline +=%F             " full file name and path
set statusline +=\ [%v\,%l/%L]  " cursor column , cursor line / total lines

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

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar
let NERDTreeMouseMode=1 " Single click for everything
" Open NERDTree by default if no files are specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Fullscreening
if has("gui_running")
  set fuoptions=maxvert,maxhorz
  map <C-f> :set fullscreen!<CR>
endif
