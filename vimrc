execute pathogen#infect()

set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set nowrap
set visualbell
set number

" Make sure terminal is running with modified Base16 colours:
" https://raw.github.com/chriskempson/base16-shell/master/base16-default.dark.sh
let base16colorspace=256
colorscheme base16-default
set background=dark
" Base16 doesn't define a nice background colour for the sign column
autocmd ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE

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
set guifont=Monaco:h10
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

" Specific indentation settings for ColdFusion
autocmd FileType cf set ai sw=4 ts=4 sts=4 noet

" Turn off auto-commenting (i.e. type a comment, press return, the new line is
" no longer automatically commented)
autocmd FileType * setlocal formatoptions-=ro

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

" Quick git-blame for the selected block
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Open .vimrc for editing in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>
" Source the vimrc file after saving it
autocmd bufwritepost .vimrc source $MYVIMRC

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a\| :Tabularize /\|<CR>
  vmap <Leader>a\| :Tabularize /\<CR>
endif
