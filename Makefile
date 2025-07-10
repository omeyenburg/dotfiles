.PHONY: help git tmux link theme qmk firefox-config nixos-backup

COLOR_RED := \033[0;31m
COLOR_DEFAULT := \033[0m

DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DOTFILES

# Info
help:
	@sh "$(DOTFILES)scripts/utils/help.sh"

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
# Link css theme files for hyprland
theme:
	@sh "$(DOTFILES)scripts/setup/bat.sh"
	@sh "$(DOTFILES)scripts/setup/fonts.sh"
	@sh "$(DOTFILES)scripts/setup/hypr.sh"

# Link qmk keyboards
qmk:
	@sh "$(DOTFILES)scripts/setup/qmk.sh"

# Generate user.js for firefox
firefox-config:
	@sh "$(DOTFILES)scripts/build/firefox-config.sh"

# Copy nixos configuration to ./nixos
nixos-backup:
	@cp -r /etc/nixos/* "$(DOTFILES)/nixos"
