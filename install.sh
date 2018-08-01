#!/usr/bin/env bash

if ! hash git 2>/dev/null || ! hash curl 2>/dev/null; then
    echo "git or curl is not installed"
    echo "Please ensure both are installed and rerun the script"
    exit 127
fi

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

#   Ensure no .vimrc before Vundle install (themes will cause errors)
if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc_old
fi
#   Copy .vimrc
cp ./vim/.vimrc ~/.vimrc_new

#   Vundle install
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

#   YouCompleteMe and YCMD server setup
cd ~/.vim/ycmd
git submodule update --init --recursive
python3 build.py --clang-completer --go-completer --java-completer 

cd ~/.vim/bundle/YouCompleteMe
git sumbodule update --init --recursive
python3 install.py --clang-completer --go-completer --java-completer 

#    Setup complete, place .vimrc
mv ~/.vimrc_old ~/.vimrc

