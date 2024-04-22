# Dotfiles

These are my [dotfiles](https://wiki.archlinux.org/title/Dotfiles). I manage them with [`GNU Stow`](https://www.gnu.org/software/stow/manual/html_node/Introduction.html#Introduction).

## emacs

1. Install `emacs`
2. Install `doom-emacs`, `doom upgrade`
3. `stow emacs`

Various emacs packages may have system dependencies. Check `*Warnings*` and `*Messages*` buffers for details if things aren't working correctly.


## ibus

1. Install `ibus` and `ibus-mozc`.

2. `stow ibus`

3. (Optionally) Enable/Start the `systemd` service.

``` sh
systemctl --user enable ibus.service
systemctl --user start ibus.service
```
