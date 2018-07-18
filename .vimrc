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
Plugin 'vim-airline/vim-airline'

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
set scrolloff=9999

" set encryption default
set cm=blowfish2

" incremental, highlighted, case insensitive smart search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Insert mode absolute line hi numbers
" Command mode relative linehi  numbers
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
:augroup END

" switch tabs with Ctrl left and right
nnoremap <C-right> :tabnext<CR>
nnoremap <C-left> :tabprevious<CR>
" and whilst in insert mode
inoremap <C-right> <Esc>:tabnext<CR>
inoremap <C-left> <Esc>:tabprevious<CR>

" one location for swap files to avoid spam
set directory^=$HOME/.vim/swapfiles//

" persistent undo upon file close
set undodir=~/.vim/undodir
set undofile

" global clipboard
set clipboard=unnamedplus

" *** NON-VUNDLE PLUGINS  ***
set runtimepath^=~/.vim/bundle/ctrlp.vim
