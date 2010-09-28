" pathogen setup
filetype off
call pathogen#runtime_append_all_bundles()

" it's 201x people: use Vim settings, rather then Vi
set nocompatible

" shift the leader key somewhere nicer
let mapleader = ","

" general settings
colorscheme ir_black " change colorscheme
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
set relativenumber
set undofile
set nowrap
set hidden " allow easy (unsaved) hidden buffers

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

" status line settings
set statusline=%f " tail of the filename
set statusline+=\ [%c\,%l/%L]  " cursor column , cursor line / total lines
set statusline+=\ %{fugitive#statusline()}
set laststatus=2

" various GUI options
set guioptions-=T " remove the toolbar
set guifont=Menlo:h12
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

" NERDTree ********************************************************************
:noremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar
let NERDTreeMouseMode=1 " Single click for everything

" Ack *************************************************************************
map <leader>a :Ack

