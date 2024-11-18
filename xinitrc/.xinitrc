[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

source $HOME/.config_path

dunst &
exec i3
