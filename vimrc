" Plugins managed by vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin()

Plug 'tpope/vim-sensible'       " start with a sensible set of defaults

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'davejlong/cf-utils.vim'
Plug 'tpope/vim-markdown'
Plug 'fatih/vim-go'

Plug 'tpope/vim-fugitive'       " all the git things
Plug 'airblade/vim-gitgutter'   " show git diff marks in the gutter
Plug 'tpope/vim-endwise'        " correct insertion of 'end' block markers
Plug 'airblade/vim-rooter'      " change working directory to project root
Plug 'ervandew/supertab'        " use tab for all insert mode completions
Plug 'vim-airline/vim-airline'  " better status/tabline
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'  " colour scheme
Plug 'scrooloose/nerdcommenter' " simple block commenting
Plug 'scrooloose/syntastic'     " syntax checking
Plug 'ctrlpvim/ctrlp.vim'       " file finding
Plug 'majutsushi/tagbar'        " tags sidebar
Plug 'junegunn/vim-peekaboo'    " register content viewer

Plug 'scrooloose/nerdtree',    { 'on': 'NERDTreeToggle' } " file explorer
Plug 'godlygeek/tabular',      { 'on': 'Tabularize' }     " block alignment

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh', 'on': [] }
augroup load_ycm  " only load YCM when entering insert mode for the first time
  if (v:version > 703 || v:version == 703 && has('patch584')) && has('python')
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe')
                       \| call youcompleteme#Enable()
                       \| autocmd! load_ycm
  endif
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
set title

" No path munging for crontabs
au FileType crontab set nobackup nowritebackup

" Make sure terminal is running with modified Base16 colours:
" https://raw.github.com/chriskempson/base16-shell/master/base16-default.dark.sh
let base16colorspace=256
silent! colorscheme base16-default-dark

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

" Assuming we're using a Powerline-supported font
let g:airline_powerline_fonts = 1

" Various GUI options
if has('gui_running')
  set guifont=Hack:h10
  set guioptions-=T " remove the toolbar
  set linespace=-2
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

" Specific indentation settings different filetypes
augroup indentation
  autocmd!
  autocmd FileType cf,go set ai sw=4 ts=4 sts=4 noet
  autocmd FileType markdown set ai sw=4 ts=4 sts=4
augroup END

" Turn off auto-commenting (i.e. type a comment, press return, the new line is
" no longer automatically commented)
augroup auto_commenting
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

" NERDTree
map <C-n> :NERDTreeToggle <CR>
let NERDTreeHijackNetrw=1 " Use instead of Netrw when doing an edit /foobar
let NERDTreeMouseMode=1 " Single click for everything
function! StartNERDTree()
  if argc() == 0 && !exists("s:std_in")
    execute ":NERDTree"
    wincmd p
  endif
endfunction

augroup nerdtree
  autocmd!
" Open NERDTree by default if no files are specified
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * :call StartNERDTree()
  " Close vim if NERDTree is the only window left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

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
augroup resource_vimrc
  autocmd!
  autocmd bufwritepost vimrc source $MYVIMRC
augroup END

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

" Use unnamed register for integration with OS X clipboard
set clipboard=unnamed

" Only run git-gutter on file read/write, not buffer/tab/focus change
let g:gitgutter_realtime=0
let g:gitgutter_eager=0

" Use ctrl-t for file-finding
let g:ctrlp_map = '<c-t>'

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

" Syntastic configuration
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_aggregate_errors = 1
let g:syntastic_go_checkers = ['go', 'golint', 'govet']

function! ErrorLocToggle()
  if exists("g:errors_win")
    lclose
    unlet g:errors_win
  else
    Errors
    let g:errors_win = bufnr("$")
  endif
endfunction

nmap <silent> <C-e> :call ErrorLocToggle()<CR>

au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['css', 'rb=ruby', 'erb=eruby', 'ruby', 'javascript', 'js=javascript', 'json=javascript', 'sass', 'xml', 'html', 'go', 'sql']

let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

nmap <Leader>s :TagbarToggle<CR>
nmap <Leader>m :!open -a "Marked 2" %<CR><CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
