#!/bin/bash
#   Credit:
#       github.com/jessfraz/dotfiles

profile_file='/usr/share/defaults/etc/profile'
if [[ -r "$profile_file" ]]; then
    # shellcheck disable=SC1090
    source "$profile_file";
fi
unset profile_file

uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${uname_out}"
esac
unset uname_out

if [ "${machine}" == 'Mac' ]
then
    eval "$(gdircolors ~/.dir_colors)";
else
    eval "$(dircolors ~/.dir_colors)"
fi

#   SSH agent
# shellcheck disable=SC1090
source ~/.ssh-find-agent.sh
set_ssh_agent_socket

#   Define GOPATH
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

#   Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob &>/dev/null

#   Append to the Bash history file, rather than overwriting it
shopt -s histappend &>/dev/null

#   Allow bash recursive globbbing
shopt -s globstar &>/dev/null

#   Typing out a path on it's own will cd into it
shopt -s autocd &>/dev/null

#   Check window size after each command
shopt -s checkwinsize &>/dev/null

#   Allow for cd <var>
shopt -s cdable_vars &>/dev/null

#   Allows cycling through options
bind 'TAB':menu-complete

if [ "${machine}" == 'Mac' ]
then
    #   Source bash and git auto-complete
    # shellcheck disable=SC1091,SC2015
    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
        # if not found in /usr/local/etc, try the brew --prefix location
        # shellcheck source=/usr/local
        [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . "$(brew --prefix)"/etc/bash_completion.d/git-completion.bash
    }
fi

for file in ~/.{aliases,functions,exports,custom}; do
    if [[ -r "$file" ]]; then
        # shellcheck disable=SC1090
        source "$file"
    fi
done

unset file
