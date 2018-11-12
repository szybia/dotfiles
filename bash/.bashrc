#!/bin/bash
#   Credit:
#       github.com/jessfraz/dotfiles

source /usr/share/defaults/etc/profile
source ~/.aliases

#   Add go bin to path
PATH=$PATH:~/go/bin

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

#   History time format
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTSIZE=1000000
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;

#   Tab case insensitive autocompletion
bind 'set completion-ignore-case on'

# List all matches in case multiple possible completions are possible
bind 'set show-all-if-ambiguous on'

# Do not autocomplete hidden files unless the pattern explicitly begins with a dot
bind 'set match-hidden-files off'

# Show all autocomplete results at once
bind 'set page-completions off'

# If there are more than 100 possible completions for a word, ask to show them all
bind 'set completion-query-items 100'

# Show extra file information when completing, like `ls -F` does
bind 'set visible-stats on'

# Allows cycling through options
bind 'TAB':menu-complete

# Partial completion of first tab, cycling on second onwards
bind "set menu-complete-display-prefix on"

#   FUNCTIONS
mkcd() {
    mkdir -p "$1"
    cd "$1"
 }

cdls() {
    cd "$1"
    ls
}

md5check () {
    md5sum "$1" | grep "$2"
}

sha256check () {
    sha256sum "$1" | grep "$2"
}

histg () {
    history | grep "$1"
}

extract() {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#   List all contents of current directory sorted by size
sbsall() {
        du -b --max-depth 1 | \
        sort -nr | \
        perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e';
}

#   List non-hidden directories of current directory sorted by size
sbs() { du -hsx * | sort -rh; }

up() {
    times=$1
    while [ "$times" -gt "0" ]; do
        cd ..
        times=$(($times - 1))
    done
}

# Make a temporary directory and enter it
tmpcd() {
	local dir
	if [ $# -eq 0 ]; then
		dir=$(mktemp -d)
	else
		dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
	fi
	cd "$dir" || exit
}

# Compare original and gzipped file size
gz() {
	local origsize
	origsize=$(wc -c < "$1")
	local gzipsize
	gzipsize=$(gzip -c "$1" | wc -c)
	local ratio
	ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
	printf "orig: %d bytes\\n" "$origsize"
	printf "gzip: %d bytes (%2.2f%%)\\n" "$gzipsize" "$ratio"
}

# check if uri is up
isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		notify-send --urgency=critical "$uri is down"
	else
		notify-send --urgency=low "$uri is up"
	fi
}

# define word
def() {
    /usr/bin/firefox --new-tab -search "define $1"
}

# word synonym
syn() {
    /usr/bin/firefox --new-tab -search "synonym $1"
}

bg-wall () {
    DIR="${HOME}/Dropbox/Wallpapers"
    PIC=$(ls $DIR/* | shuf -n1)

    gsettings set org.gnome.desktop.background picture-uri "file://$PIC"
}

#   Create backup file
backup() { cp "$1"{,.bak};}

# Only show n directorys in terminal working path
export PROMPT_DIRTRIM=2
