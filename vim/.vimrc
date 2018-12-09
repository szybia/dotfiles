"   Default python version
if has('python3')
   set pyx=3
else
   set pyx=2
endif

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
Plugin 'itchyny/lightline.vim'
    set laststatus=2
    let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ }
Plugin 'davidhalter/jedi-vim'
Plugin 'airblade/vim-gitgutter'
    " set vim update time to quarter of a second for git tracking
    set updatetime=250
    let g:gitgutter_max_signs = 500  " only show 500 changes
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}

if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plugin 'zchee/deoplete-go', { 'do': 'make'}
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plugin 'artur-shaik/vim-javacomplete2'
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
Plugin 'scrooloose/nerdcommenter'
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
Plugin 'Raimondi/delimitMate'
Plugin 'ntpeters/vim-better-whitespace'
    let g:better_whitespace_enabled=1
    let g:strip_whitespace_on_save=1
Plugin 'tpope/vim-endwise'
Plugin 'Yggdroot/indentLine'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'

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


" ---------- Themes and Aeshetic ----------

" dark theme
set background=dark
colorscheme palenight


" ---------- Searching ----------

" incremental, highlighted, case insensitive smart search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Quick search
map <space> /
map <c-space> ?

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



" ---------- Vim defaults ----------

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

" Remap VIM 0 to first non-blank character
map 0 ^

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


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



" ---------- Functions ----------


" Delete trailing white space on save, useful for some file types ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun



" ---------- Miscalleanous ----------

" netrw NERDtree like setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

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
