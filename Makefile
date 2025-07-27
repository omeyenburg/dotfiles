.PHONY: help git tmux link fonts theme-install theme-update qmk firefox-config nixos-backup

COLOR_RED := \033[0;31m
COLOR_DEFAULT := \033[0m

DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DOTFILES

# Print info
help:
	@sh "$(DOTFILES)scripts/utils/help.sh"

# Apply git configuration
git:
	@sh "$(DOTFILES)scripts/setup/git.sh"

# Install tmux plugins
tmux:
	@sh "$(DOTFILES)scripts/setup/tmux.sh"

# Link configuration files and scripts in config/, home/ and scripts/bin/
link:
	@sh "$(DOTFILES)scripts/setup/link.sh"

# Install FiraCode and FiraMono font
fonts:
	@sh "$(DOTFILES)scripts/setup/fonts.sh"

# Install Catppuccin Mocha theme for bat
theme-install: theme-update
	@sh "$(DOTFILES)scripts/setup/theme-install.sh"

# Generate CSS files
theme-update:
	@sh "$(DOTFILES)scripts/setup/theme-update.sh"

# Link qmk keyboards
qmk:
	@sh "$(DOTFILES)scripts/setup/qmk.sh"

# Generate user.js for firefox
firefox-config:
	@sh "$(DOTFILES)scripts/build/firefox-config.sh"

# Copy nixos configuration to ./nixos
nixos-backup:
	@cp -r /etc/nixos/* "$(DOTFILES)/nixos"
