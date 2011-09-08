" pathogen setup
filetype on " if filetype is already off, turning it off throws an error
filetype off
filetype plugin indent on
call pathogen#runtime_append_all_bundles()

" it's 201x people: use Vim settings, rather then Vi
set nocompatible

" normal map leader
let mapleader = "\\"

" general settings
"colorscheme ir_black " change colorscheme
set background=dark
colorscheme solarized " change colorscheme
syntax on " syntax highlighting on by default
set number " turn on line numbers
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set ts=4 sts=4 sw=4 noexpandtab " always tabs, displayed as four spaces
set list
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set nowrap
set hidden " allow easy (unsaved) hidden buffers

" visual indicator to keep lines short
if exists('+colorcolumn')
  " highlight the 80th column (only in 7.3+)
  set colorcolumn=80
else
  " highlight any text that goes over 80 characters
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" code folding
set foldmethod=indent   " fold based on the indent level
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " don't fold by default
set foldlevel=1

" arrow keys are banned
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" quick new vertical split
nnoremap <leader>w <C-w>v<C-w>l
" quickly move around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Mac-standard tab navigation
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

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
set statusline=%f " tail of the filename
set statusline+=\ [%c\,%l/%L]  " cursor column , cursor line / total lines
set statusline+=\ %{fugitive#statusline()}
set laststatus=2

" various GUI options
set guioptions-=T " remove the toolbar
set guifont=Menlo:h10
set linespace=2 " add a little linespace for readability

" shortcut to show invisibles (tabs, carriage returns)
nmap <leader>i :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" helpful function to preserve cursor location and history
function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" do the business:
	execute a:command
	" clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

" strip all trailing whitespace
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" reformat indentation
nmap _= :call Preserve("normal gg=G")<CR>

" open .vimrc for editing in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" clear backups and swaps out of the working directory
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//

" newer vim settings
if has("gui_running")
  set relativenumber
  " persistent undo files storage
  set undofile
  set undodir=~/.vim/tmp//
  " make full screen mode actually go full screen
  set fuopt=maxvert,maxhorz
endif

" use F2 to toggle auto-indenting for code pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

"Move a line of text using Comamnd+[jk] on mac
nmap <D-j> mz:m+<cr>`z
nmap <D-k> mz:m-2<cr>`z
vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z

" NERDTree ********************************************************************
:noremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar
let NERDTreeMouseMode=1 " Single click for everything

" Ack *************************************************************************
map <leader>a :Ack

" Filetype specifics **********************************************************
augroup myfiletypes
  autocmd!
  autocmd FileType ruby,eruby,yaml,mkderb set ai sw=2 sts=2 et
  autocmd BufNewFile,BufReadPost *.md set filetype=mkderb
augroup END

" Solarized colour scheme ****************************************************
call togglebg#map("<F5>")

" Scratch *********************************************************************
map <leader>s :Scratch<CR>
map <leader>S :Sscratch<CR>

" Markdown preview
map <leader>m <ESC>:w!<CR>:!markit % > /tmp/%:t.html && open /tmp/%:t.html<CR><CR>

" Fuzzy finder help
map <leader>h :FufHelp<CR>

" NERD Commenter locals
let NERDCommentWholeLinesInVMode=2
map <C-C> <plug>NERDCommenterToggle
