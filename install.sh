#!/usr/bin/env bash

if ! hash git 2>/dev/null || ! hash curl 2>/dev/null; then
    echo "git or curl is not installed"
    echo "Please ensure both are installed and rerun the script"
    exit 127
fi

if [ -f ~/.bashrc ] || [ -f ~/.vimrc  ]; then
    echo ".bashrc or .vimrc has been found in your home folder."
    echo "Your files will be renamed to <filename>_old"
    read -p "Are you sure you want to proceed? (y/n): " yn
    case $yn in 
        [^Yy]) exit 0;;
    esac

    if [ -f ~/.bashrc ]; then
        mv ~/.bashrc ~/.bashrc_old
    fi

    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc_old
    fi
fi

#   Copy .bashrc and rerun
cp ./bash/.bashrc ~/.bashrc
source ~/.bashrc

#   Ensure all .vim folders exist
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/undodir

#   Copy .vimrc
cp ./vim/.vimrc ~/.vimrc

#   Vundle install
if [ ! -f ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

#   YouCompleteMe and YCMD server setup
cd ~/.vim/bundle/ycmd
git submodule update --init --recursive
python3 build.py --clang-completer --go-completer --java-completer

cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
python3 install.py --clang-completer --go-completer --java-completer

#   Copying ycm config file for c++ support
cp ./vim/.ycm_extra_conf.py ~/.vim/bundle/YouCompleteMe/third_party/ycmd/
