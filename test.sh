#!/bin/bash
#   Credit:
#       https://github.com/jessfraz/dotfiles/blob/master/test.sh
set -e
set -o pipefail

ERRORS=()

for f in $(find . -type f -not -iwholename '*.git*' -not -name "yubitouch.sh" | sort -u); do
	if file "$f" | grep --quiet shell; then
		{
			shellcheck "$f" && echo "[OK]: successfully linted $f"
		} || {
			ERRORS+=("$f")
		}
	fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "No errors, hooray"
else
	echo "These files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi
