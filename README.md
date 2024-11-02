# dotfiles
Here are my dotfiles ( (always) work-in-progress).
This is meant to support only OpenSUSE with Hyprland for now.
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
- yazi
- btop
- tmux
- kitty
- neovim
- fastfetch
- pavucontrol
- ranger
- rustup
- gimp
- wofi
- mako
- waybar
- hyprland
- hypridle
- hyprshot
- hyprpicker
- whatsapp-for-linux
- python311-virtualenv
- NetworkManager-applet
- blueman
- zathura
- texlive-latexmk
- brave-browser
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper install brave-browser
sudo zypper removerepo brave-browser

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

### Installing a nerdfont
Nerdfonts are adjusted fonts that contain additional unicode symbols that can be rendered in the terminal. For this config, I chose the UbuntuMono Nerd Font. You can find and download nerdfonts [here](https://www.nerdfonts.com/).

To download the UbuntuMono Nerd Font run:
```
mkdir font-tmp
cd font-tmp
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.tar.xz
tar -xJf UbuntuMono.tar.xz

mkdir -p ~/.local/share/fonts
cp UbuntuMonoNerdFontMono-Regular.ttf ~/.local/share/fonts/
fc-cache -f -v
```

Or with zip format:
```
...
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip
unzip UbuntuMono.zip -d UbuntuMono
...
```
