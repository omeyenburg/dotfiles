# dotfiles
Here are my dotfiles (work-in-progress).  
This is meant to support only OpenSUSE and MacOS atm.  
I use hyprland as my main deskop environment, but there is some kde plasma configuration flying around.
There is configuration for zsh and bash.  
QMK has also some configuration, but is only needed for custom keyboards.

## Apps
Here is a list of apps to be installed

should be preinstalled with OpenSUSE:
- firefox
- kde plasma
- pavucontrol

might be preinstalled:
- gcc
- clang
- python3 (3.11)
- wl-clipboard or smth

zypper:
- alacritty
- git
- curl
- waybar
- hyprland
- hyprpicker
- wofi
- mako
- neovim
- gimp
- neofetch
- ranger
- rustup
- whatsapp-for-linux
- tmux

flatpack:
- discord
- spotify

should be shipped with hyprland:
- swaylock

others:
- nerdfont: UbuntuMono Nerd Font

## Installation
To link the config files run:
./link.sh

to give execution permissions to link.sh run chmod +x link.sh

## Post-Installation

### SSH
To use git properly you will need to create an ssh key.

Generate a key with ed25519:
ssh-keygen -t ed25519 -C "your_email@example.com"

Add the SSH key to the SSH agent:
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

Copy the public key and paste it in Github:
cat ~/.ssh/id_ed25519.pub

Verify connection:
ssh -T git@github.com

## TODO
- move app list to separate file
- interactive app installer
- interactive setup scripts
- symbolic links
- global colorscheme
