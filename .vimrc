" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype on
au BufNewFile,BufRead *.rs set filetype=rust

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set background=dark

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V#%b%)\ %P
set number

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 list
set autoindent

set listchars=eol:¶

set <F1>=[11~
set <F2>=[12~
set <F3>=[13~
set <F4>=[14~
set <F5>=[15~
set <F6>=[17~
set <F7>=[18~
set <F8>=[19~
set <F9>=[20~
set <F10>=[21~
set <F11>=[23~
set <F12>=[24~

nmap <F1> :w<CR>:!raku -I ./lib %<CR>
imap <F1> <esc>:w<CR>:!raku --ll-exception -I ./lib %<CR>
nmap <F2> :w<CR>:!make test<CR>
imap <F2> <esc>:w<CR>:!make test<CR>
nmap <F3> :new<CR>:0read ! raku #<CR>:wincmd j<CR>

nmap <F5> :!git commit %<CR>
nmap <F6> :!make push<CR>
nmap <F7> :!git diff %<CR>

function! ListCharToggle()
    if &listchars == "eol:¶"
        set listchars=
    else
        set listchars=eol:¶
    endif
endfunction

nmap <F9> :set number!<CR>:call ListCharToggle()<CR>

map <C-H> :wincmd h<CR>
map <C-J> :wincmd j<CR>
map <C-K> :wincmd k<CR>
map <C-L> :wincmd l<CR>

nnoremap <Esc>1 1gt
nnoremap <Esc>2 2gt
nnoremap <Esc>3 3gt
nnoremap <Esc>4 4gt
nnoremap <Esc>5 5gt
nnoremap <Esc>6 6gt
nnoremap <Esc>7 7gt
nnoremap <Esc>8 8gt
nnoremap <Esc>9 9gt
nnoremap <Esc>0 10gt
nnoremap <Esc>[C gt
nnoremap <Esc>[D gT


syntax off

" let &t_SI = "\<Esc>[6 q"
" let &t_SR = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"

nnoremap <silent> gw "_yiw:s/\(\%#\S\+\)\(\s\+\)\(\S\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>

set colorcolumn=80
set t_Co=256

"airline statusbar
set laststatus=2
set ttimeoutlen=50
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'

autocmd FileType rakudotest nmap <F1> :w<CR>:!./testcase %<CR>
