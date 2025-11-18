[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

source $HOME/.config_path
source $HOME/.config_ibus

dunst &
# picom &
xrandr --output DP-0 --mode 3840x2160 --rate 240.02
nvidia-settings --load-config-only

exec i3
