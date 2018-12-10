#!/bin/bash
#   Credit:
#       https://github.com/jessfraz/dotfiles/blob/master/test.sh
set -e
set -o pipefail

PASSED=()
ERRORS=()

for f in $(find . -type f -not -path '*.git*' | sort -u); do
    if file "$f" | grep --quiet shell; then
        {
            shellcheck "$f" && PASSED+=("$f")
        } || {
            ERRORS+=("$f")
        }
    fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "No errors";
else
    echo "These files passed shellcheck: ${PASSED[*]}";
	echo "These files failed shellcheck: ${ERRORS[*]}";
	exit 1;
fi
