" Plugins managed by vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin()

Plug 'tpope/vim-sensible'       " start with a sensible set of defaults

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'davejlong/cf-utils.vim'
Plug 'tpope/vim-markdown'
Plug 'fatih/vim-go'
Plug 'elixir-lang/vim-elixir'

Plug 'tpope/vim-fugitive'       " all the git things
Plug 'airblade/vim-gitgutter'   " show git diff marks in the gutter
Plug 'tpope/vim-endwise'        " correct insertion of 'end' block markers
Plug 'airblade/vim-rooter'      " change working directory to project root
Plug 'ervandew/supertab'        " use tab for all insert mode completions
Plug 'fholgado/minibufexpl.vim' " easier buffer exploring
Plug 'bling/vim-airline'        " better status/tabline
Plug 'chriskempson/base16-vim'  " colour scheme
Plug 'scrooloose/nerdcommenter' " simple block commenting

Plug 'scrooloose/nerdtree',    { 'on': 'NERDTreeToggle' } " file explorer
Plug 'godlygeek/tabular',      { 'on': 'Tabularize' }     " block alignment

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh', 'on': [] }
augroup load_ycm  " only load YCM when entering insert mode for the first time
  autocmd!
  autocmd InsertEnter * call plug#load('YouCompleteMe')
                     \| call youcompleteme#Enable()
augroup END

call plug#end()

" ----------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set nowrap
set visualbell
set number

" No path munging for crontabs
au FileType crontab set nobackup nowritebackup

" Make sure terminal is running with modified Base16 colours:
" https://raw.github.com/chriskempson/base16-shell/master/base16-default.dark.sh
let base16colorspace=256
silent! colorscheme base16-default
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
if has('gui_running')
  if system("uname") == "Darwin\n"
    set guifont=Inconsolata-dz\ for\ Powerline:h12
    let g:airline_powerline_fonts = 1
    set guioptions-=T " remove the toolbar
    set linespace=-2
   endif
endif

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

" Open splits below / right
set splitbelow
set splitright

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
map <C-n> :NERDTreeToggle <CR>
let NERDTreeHijackNetrw=1 " Use instead of Netrw when doing an edit /foobar
let NERDTreeMouseMode=1 " Single click for everything
" Open NERDTree by default if no files are specified
autocmd StdinReadPre * let s:std_in=1
function! StartNERDTree()
  if argc() == 0 && !exists("s:std_in")
    execute ":NERDTree"
    wincmd p
  endif
endfunction
autocmd VimEnter * :call StartNERDTree()
" Close vim if NERDTree is the only window left open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

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
autocmd bufwritepost vimrc source $MYVIMRC

" Tabularize shortcuts
nmap <Leader>a= :Tabularize /\zs[=<>/!]\@<!=[=<>/!]\@!.*/<CR>
vmap <Leader>a= :Tabularize /\zs[=<>/!]\@<!=[=<>/!]\@!.*/<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a\| :Tabularize /\|<CR>
vmap <Leader>a\| :Tabularize /\<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a{ :Tabularize /{<CR>
vmap <Leader>a{ :Tabularize /{<CR>

let NERDCommentWholeLinesInVMode=2
nmap <C-C> <plug>NERDCommenterToggle
vmap <C-C> <plug>NERDCommenterToggle

" Powerline installation directory: https://github.com/Lokaltog/powerline
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

" Use unnamed register for integration with OS X clipboard
set clipboard=unnamed

" Only run git-gutter on file read/write, not buffer/tab/focus change
let g:gitgutter_realtime=0
let g:gitgutter_eager=0

" Pretty-print a JSON file
nmap <Leader>j :%!python -mjson.tool

" Shortcut Fugitive's Gbrowse support
nmap <Leader>b :Gbrowse<CR>
vmap <Leader>b :Gbrowse<CR>

" Set swap, backup and undo dirs
let s:dir = '~/Library/Vim'
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif
if exists('+undofile')
  set undofile
endif

" Shortcut for stripping trailing whitespace
nmap <Leader>w :%s/\s\+$<CR>
