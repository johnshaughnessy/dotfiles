#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
# polybar --config="$HOME/.config/polybar/bar1" bar1
polybar --config="$HOME/.config/polybar/modern2" top
