.PHONY: help git tmux link unlink theme qmk hypr nixos-backup

COLOR_RED := \033[0;31m
COLOR_DEFAULT := \033[0m

DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DOTFILES

# Apply git configuration
git:
	@sh "$(DOTFILES)scripts/setup/git.sh"

# Install tmux plugins
tmux:
	@sh "$(DOTFILES)scripts/setup/tmux.sh"

# Link configuration files
link:
	@sh "$(DOTFILES)scripts/setup/link.sh"

# Install FiraCode and FiraMono font
# Install Catppuccin Mocha theme for bat
theme:
	@sh "$(DOTFILES)scripts/setup/bat.sh"
	@sh "$(DOTFILES)scripts/setup/fonts.sh"

# Link qmk keyboards
qmk:
	@sh "$(DOTFILES)scripts/setup/qmk.sh"

# Link css theme files for hyprland
hypr:
	@ln -s ~/.config/hypr/themes/catppuccin.css ~/.config/hypr/themes/current.css
	@ln -s ~/.cache/wal/colors-waybar.css ~/.config/hypr/themes/pywal.css

# Copy nixos configuration to ./nixos
nixos-backup:
	@cp -r /etc/nixos/* "$(DOTFILES)/nixos"
