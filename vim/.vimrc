"   Install Vim-Plug if it isn't installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"   Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'

Plug 'airblade/vim-gitgutter'
    " set vim update time to quarter of a second for git tracking
    set updatetime=250
    let g:gitgutter_max_signs = 500  " only show 500 changes

Plug 'ntpeters/vim-better-whitespace'
    autocmd BufWritePre * :StripWhitespace

Plug 'scrooloose/nerdcommenter'
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not
    let g:NERDToggleCheckAllLines = 1

Plug 'dylanaraps/fff.vim'
let g:fff#split = "30new"

Plug 'tpope/vim-surround'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

" ---------- Searching ----------

autocmd VimEnter * colorscheme wombat

" ---------- Searching ----------

" incremental, highlighted, case insensitive smart search
set incsearch
set hlsearch
set ignorecase
set smartcase

" "Scroll" through file
map <Space> 10j
map <C-@> 10k

" ---------- Cursor and rulers ----------

" show the cursor position
set ruler

" cursor centered
set scrolloff=10

" show cursorline when in insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Insert mode absolute line numbers
" Command mode relative line numbers
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
:augroup END

" Add new line to file if doesn't exist
autocmd BufWritePre * if (getline('$') !~ "^\s*$") | call append(line('$'), "") | endif

"
" ---------- Vim defaults ----------

" be iMproved, required
set nocompatible

" keep 500 items in the history
set history=500

" show incomplete commands
set showcmd

" show a menu when using tab completion
set wildmenu

" set encryption default
set cm=blowfish2

" global clipboard
set clipboard=unnamedplus

" prevent linebreak within word
set lbr

" map leader
let mapleader=','

" default encoding
set encoding=utf-8

" Dont redraw when executing macros
set lazyredraw

" Regex magic
set magic

" Read file when it is changed from the outside
set autoread

" Set 15 lines to the cursor when moving vertically
set so=15

let $LANG='en'
set langmenu=en

" Height of bottom command bar
set cmdheight=2

" Unix standard file type
set ffs=unix,dos,mac

set noerrorbells

" speed up syntax highlighting
set nocursorcolumn
set nocursorline


" ---------- Windows and buffers ----------

" switch windows with Ctrl + arrow keys
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
" and whilst in insert mode
inoremap <C-l> <ESC><C-W>l
inoremap <C-h> <ESC><C-W>h
inoremap <C-k> <ESC><C-W>k
inoremap <C-j> <ESC><C-W>j



" ---------- Useful remappings ----------

" Call ESC on Ctrl-C
inoremap <C-c> <ESC>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sr z=

" Open NERDTREE
map <leader>n :NERDTree<cr>


" ---------- Undo, swap and backup files ----------

" specific locations for undo, swap and backup files to avoid spam
set undodir=~/.vim/undodir//
set backupdir=~/.vim/backup//
set directory=~/.vim/swapfiles//

" persistent undo upon file close
set undodir=~/.vim/undodir
set undofile


" ---------- White-space and indentation ----------

" automatic smart indent
set ai
set si

" enable folding
set foldmethod=indent
set foldlevel=99

" tabs to spaces
set expandtab
" smart tab
set smarttab
" tab size 4 spaces
set tabstop=4
" shift width 4 spaces
set shiftwidth=4

" always split evenly
autocmd VimResized * wincmd =

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" shortcut to delete in the black hole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" shortcut to paste but keeping the current register
vnoremap <leader>p "_dP

" set ~/.custom filetype to be bash
au BufRead,BufNewFile .custom,.dockerfunc,.dockeralias set filetype=bash

" detect MacOS and relevent overrides
let s:uname = system('echo -n "$(uname -s)"')
if !v:shell_error && s:uname == 'Darwin'
    set clipboard=unnamed
endif

" Treat :Wq as :wq to save time
:command W w
:command Wq wq
:command WQ wq

:command Cq cq
:command CQ cq

:command Q q

