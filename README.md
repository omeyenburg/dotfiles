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

### TMUX
Create a .tmux/plugins folder in your home directory.
mkdir ~/.tmux
mkdir ~/.tmux/plugins
(NOTE: ↑ that can be one line)
(EDIT#2: actually tpm automatically puts plugins where the config is)

Clone tpm into .tmux.
git clone git@github.com:tmux-plugins/tpm .tmux/plugins/tpm

### SSH
To use git properly you will need to create an ssh key.

Generate a key with ed25519:
ssh-keygen -t ed25519 -C "135001586+omeyenburg@users.noreply.github.com"

Add the SSH key to the SSH agent:
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

Copy the public key and paste it in [Github](https://github.com/settings/keys)
cat ~/.ssh/id_ed25519.pub

Verify connection:
ssh -T git@github.com

### Sleeping issues

Some grub args have to be modified.
edit with:
sudo vim /etc/default/grub

Here is a working list of args, most of which are probably not needed or useful
GRUB_CMDLINE_LINUX_DEFAULT="splash=silent quiet pcie_aspm=force nohibernate=1 acpi=copy_dsdt security=apparmor amd_iommu=off mitigations=auto acpi_osi=Linux"

and update grub with:
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
This might be needed if the error is related to brcmf:
Run:
sudo nano /etc/modprobe.d/blacklist-brcmf.conf
And add:
blacklist brcmf

## Installing a nerdfont
Nerdfonts are adjusted fonts that contain additional unicode symbols that can be rendered in the terminal. For this config, I chose the UbuntuMono Nerd Font. You can find and download nerdfonts [here](https://www.nerdfonts.com/).

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.tar.xz
unzip UbuntuMono.zip -d UbuntuMono

## TODO
- move app list to separate file
- interactive app installer
- interactive setup scripts
- symbolic links
- global colorscheme
- easy font switching
