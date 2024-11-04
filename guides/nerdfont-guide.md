# Installing a nerdfont
Nerdfonts are adjusted fonts that contain additional unicode symbols that can be rendered in the terminal. For this config, I chose the UbuntuMono Nerd Font. You can find and download nerdfonts [here](https://www.nerdfonts.com/).

## UbuntuMono
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
