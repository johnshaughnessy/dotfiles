[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

dunst &
exec i3
