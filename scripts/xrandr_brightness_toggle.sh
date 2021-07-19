if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    >&2 echo "$(cat <<EOF
Usage: ${0} [night]

Script which increments xrandr brightness.
Once it hits the upper bound it circles back around to low brightness.

# Exportable variables
XRANDR_OUTPUT = Value passed to xrandr --output, default is connected output.
BRIGHT_STEP   = Brightness increment value, default is 0.05. So if starting at 0.10 we go 0.15 0.20 0.25 etc.
EOF
)"
    exit 1
fi

#   Get xrandr output or figure out based on best-case effort
XRANDR_OUTPUT="${SCREEN_OUPUT:-$( xrandr | grep " connected" | cut -f1 -d" " )}"
BRIGHT_STEP="${BRIGHT_STEP:-0.05}"

CURR_BRIGHT=$( xrandr --verbose --current | grep ^"${XRANDR_OUTPUT}" -A5 | tail -n1 )
CURR_BRIGHT="${CURR_BRIGHT##* }"  # Get brightness level with decimal place

#   If brightness will overflow, tail back around to low value
if awk "BEGIN {exit !($CURR_BRIGHT + $BRIGHT_STEP > 1.0)}"; then
    NEXT_BRIGHT="${BRIGHT_STEP}"
else
    #   else increment
    NEXT_BRIGHT="$(echo "$CURR_BRIGHT + $BRIGHT_STEP" | bc)"
fi

set -ex

xrandr --output "${XRANDR_OUTPUT}" --brightness "${NEXT_BRIGHT}"

