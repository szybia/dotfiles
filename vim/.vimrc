"	*** VUNDLE SETUP ***

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'w0rp/ale'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'drewtempelmeyer/palenight.vim'
    let g:palenight_terminal_italics=1
    set noshowmode
    " GUI colours
    if (has("termguicolors"))
      set termguicolors
    endif
Plugin 'itchyny/lightline.vim'
    set laststatus=2
    let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ }
Plugin 'Valloric/ycmd'
Plugin 'Valloric/YouCompleteMe'
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
Plugin 'airblade/vim-gitgutter'
    " set vim update time to half a second for git tracking
    set updatetime=500
    let g:gitgutter_max_signs = 500  " only show 500 changes

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"	*** VUNDLE SETUP END ***

" dark theme
set background=dark
colorscheme palenight

" keep 1000 items in the history
set history=1000

" show the cursor position
set ruler

" show incomplete commands
set showcmd

" show a menu when using tab completion
set wildmenu

" show cursorline when in insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" cursor always centered
set scrolloff=10

" set encryption default
set cm=blowfish2

" incremental, highlighted, case insensitive smart search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Insert mode absolute line numbers
" Command mode relative line numbers
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
:augroup END

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

" specific locations for undo, swap and backup files to avoid spam
set undodir=~/.vim/undodir//
set backupdir=~/.vim/backup//
set directory=~/.vim/swapfiles//

" persistent undo upon file close
set undodir=~/.vim/undodir
set undofile

" global clipboard
set clipboard=unnamedplus

" prevent linebreak within word
set lbr

" automatic smart indent
set ai
set si
filetype plugin indent on

" map leader
let mapleader=','

" enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" tabs to spaces
set expandtab
" tab size 4 spaces
set tabstop=4
" shift width 4 spaces
set shiftwidth=4

" netrw NERDtree like setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" always split evenly
autocmd VimResized * wincmd =

" default encoding
set encoding=utf-8

"   default fileformat
set fileformat=unix
