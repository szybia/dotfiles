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

    #   Copy .bashrc and rerun
    if [ -f ~/.bashrc ]; then
        mv ~/.bashrc ~/.bashrc_old
    fi

    #   Ensure no .vimrc before Vundle install (themes will cause errors)
    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc_old
    fi
fi

#   -----   BASH    --------------------

#   Copy .bashrc and rerun
ln -sfr bash/.bashrc ~/.bashrc
# shellcheck source=/dev/null
source ~/.bashrc

#   -----   VIM     --------------------

#   Ensure all .vim folders exist
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swapfiles
mkdir -p ~/.vim/undodir

#   Copy .vimrc
ln -sfr vim/.vimrc ~/.vimrc

#   deoplete.nvim setup
sudo pip3 -q install neovim
sudo pip3 -q install greenlet==0.4.10

#   deoplete-go setup
go get -u github.com/mdempsky/gocode

vim +PluginInstall +qall
vim +PluginClean +qall

#   Setup vim-go
vim +GoInstallBinaries

#   Setup java complete
cd ~/.vim/bundle/vim-javacomplete2/libs/javavi
mvn compile

#   -----   gpg     --------------------
mkdir -p ~/.gnupg/
ln -sfr gnupg/gpg.conf ~/.gnupg/
