#!/bin/bash
#   Credit:
#       github.com/jessfraz/dotfiles

profile_file='/usr/share/defaults/etc/profile'
if [[ -r "$profile_file" ]]; then
    # shellcheck disable=SC1090
    source "$profile_file";
fi
unset profile_file

eval "$(dircolors ~/.dir_colors)"

#   Add go bin to path
PATH=$PATH:~/go/bin

#   Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

#   Append to the Bash history file, rather than overwriting it
shopt -s histappend

#   Autocorrect typos in path names when using `cd`
shopt -s cdspell

#   Allow bash recursive globbbing
shopt -s globstar

#   Check window size after each command
shopt -s checkwinsize

#   Typing out a path on it's own will cd into it
shopt -s autocd

#   Allows cycling through options
bind 'TAB':menu-complete

for file in ~/.{aliases,functions,exports}; do
    if [[ -r "$file" ]]; then
        # shellcheck disable=SC1090
        source "$file"
    fi
done
unset file
