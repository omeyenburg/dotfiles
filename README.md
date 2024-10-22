# dotfiles
Here are my dotfiles (work-in-progress).  
This is meant to support only OpenSUSE and MacOS atm.  
I use hyprland as my main deskop environment, but there is some kde plasma configuration flying around.
There is configuration for zsh and bash.  
QMK has also some configuration, but is only needed for custom keyboards.

## Apps
Here is a list of apps to be installed

should be preinstalled with OpenSUSE (KDE):
- firefox
- kde plasma
- python3 (3.11)

zypper:
- git
- curl
- make
- clang
- gcc
- tmux
- neovim
- neofetch
- pavucontrol
- ranger
- rustup
- gimp
- wofi
- mako
- waybar
- hyprland
- hypridle
- hyprpicker
- whatsapp-for-linux
- python311-virtualenv
- NetworkManager-applet
- blueman
- texlive-latexmk
- alacritty

flatpak:
- discord
- spotify

should be shipped with hyprland:
- swaylock

others:
- nerdfont: UbuntuMono Nerd Font

## Pre-Installation
### Github SSH
To use Github properly you will need to create an ssh key.

Generate a key with ed25519:
```
ssh-keygen -t ed25519 -C "135001586+omeyenburg@users.noreply.github.com"
```

Add the SSH key to the SSH agent:
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Copy the public key and paste it in [Github](https://github.com/settings/keys)
```
cat ~/.ssh/id_ed25519.pub
```

Verify connection with this command. If asked to continue connecting, enter "yes".
```
ssh -T git@github.com
```

## Installation
To link the config files run:
```
./scripts/link_conf.sh
./scripts/link_home.sh
```

To add the shell config to .bashrc run:
```
source scripts/shell.sh
```

To set up git run:
```
. ./scripts/git.sh
```


## Post-Installation
### Change hostname
Run this with the desired hostname:
```
sudo hostnamectl set-hostname <newhostname>
```

### Disable startup sound on mac
Command to disable macos startup sound:
```
sudo nvram StartupMute=%01
```
And to enable:
```
sudo nvram StartupMute=%00
```
https://apple.stackexchange.com/questions/431910/how-to-permanently-disable-the-mac-startup-sound

### TMUX
Run `./scripts/tmux.sh` install tpm.
Plugins can be installed with tpm by pressing <leader>+I within tmux.

### Sleeping issues
This might be a problem when booting from an external media on a MacBook.

Some grub args may have to be modified.
edit with:
```
sudo vim /etc/default/grub
```

Here is a working list of args, most of which are probably not needed or useful:
```
GRUB_CMDLINE_LINUX_DEFAULT="splash=silent quiet pcie_aspm=force nohibernate=1 acpi=copy_dsdt security=apparmor amd_iommu=off mitigations=auto acpi_osi=Linux"
```

Then update grub with:
```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

This might be needed if the error is related to brcmf:
Run:
```
sudo nano /etc/modprobe.d/blacklist-brcmf.conf
```

And add:
```
blacklist brcmf
```

### Youtube lagging in dark mode
1. enter youtube video
2. click on the video settings
3. disable ambient mode

## Installing a nerdfont
Nerdfonts are adjusted fonts that contain additional unicode symbols that can be rendered in the terminal. For this config, I chose the UbuntuMono Nerd Font. You can find and download nerdfonts [here](https://www.nerdfonts.com/).

To download the UbuntuMono Nerd Font run:
```
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.tar.xz
tar -xJf UbuntuMono.tar.xz
```

Or:
```
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip
unzip UbuntuMono.zip -d UbuntuMono
```

## TODO
- move app list to separate file
- interactive app installer
- interactive setup scripts
- global colorscheme
- easy font switching
