#!/usr/bin/env bash

if ! hash git 2>/dev/null || ! hash curl 2>/dev/null; then
    echo "git or curl is not installed"
    echo "Please ensure both are installed and rerun the script"
    exit 127
fi


#   Copy .vimrc
if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc_old
fi
cp ./vim/.vimrc ~/.vimrc


#   Copy .bashrc and rerun
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc_old
fi
cp ./bash/.bashrc ~/.bashrc
source ~/.bashrc


#   Ensure all .vim folders exist
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/undodir


#   Vundle install
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
