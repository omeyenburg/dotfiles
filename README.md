# dotfiles
Here are my dotfiles ( (always) work-in-progress).
This is meant to support only OpenSUSE with Hyprland for now.
QMK has also some configuration, but is only needed for custom keyboards.

## Installation
Firstly install at least git, or follow guides/app-guide.md.

To link the config files run:
```
make link-home
make link-conf
```

To add the shell config to .bashrc run:
```
make shell
```

To set up git run:
```
make git
```

To install tpm run:
```
make tmux
```
Plugins can be installed with tpm by pressing <leader>+I within tmux.

## Post-Installation
### Change hostname
Run this with the desired hostname:
```
sudo hostnamectl set-hostname <newhostname>
```

## Wallpapers
A collection of wallpapers can be found on the wallpaper branch.
