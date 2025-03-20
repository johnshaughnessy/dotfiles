[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

source $HOME/.config_path

dunst &
picom &
# xrandr --output DisplayPort-0 --mode 3840x2160 --rate 240.02
exec i3
