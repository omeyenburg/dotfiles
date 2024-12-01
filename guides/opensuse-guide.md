# OpenSUSE apps
Here is a list of useful and required apps. This is mostly specific to OpenSUSE.
Also, run this to set the hostname:
```
sudo hostnamectl set-hostname <newhostname>
```

## Zypper
Run this to install the listed apps below through zypper:
```
sudo zypper install git gcc yazi tmux make curl btop kitty clang neovim rustup fastfetch wofi mako waybar zenity hyprland hypridle hyprshot hyprpicker pavucontrol NetworkManager-applet blueman gimp zathura texlive-latexmk
```

### Developing
- git
- gcc
- yazi
- tmux
- make
- curl
- btop
- kitty
- clang
- neovim
- rustup
- fastfetch

### Hyprland
- wofi
- mako
- waybar
- zenity
- hyprland
- hypridle
- hyprshot
- hyprpicker
- pavucontrol
- python311-pipx

### Networking & Bluetooth
- NetworkManager-applet
- blueman

### Image viewing & editing
- gimp

### PDF viewing & editing
- zathura
- texlive-latexmk

### Browser
Firefox is usually preinstalled.
Run these commands if you want to install Brave.
```
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper install brave-browser
sudo zypper removerepo brave-browser
```

### Dependencies
#### OpenGL
- Mesa-libGL-devel

#### SDL
- libSDL2-devel

## Flatpak
- discord
- spotify
- com.github.reds.LogisimEvolution

### Scaling:
flatpak override --user com.spotify.Client --env=GDK_SCALE=1.3 --env=GDK_DPI_SCALE=0.5

## PIPX
- pywal
