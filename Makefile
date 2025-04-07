.PHONY: help git shell tmux link unlink fonts qmk hypr nixos-backup

COLOR_RED := \033[0;31m
COLOR_DEFAULT := \033[0m

DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DOTFILES

# Apply git configuration
git:
	@sh "$(DOTFILES)scripts/git.sh"

# Write bashrc and bash_profile
shell:
	@sh "$(DOTFILES)scripts/shell.sh"

# Install tmux plugins
tmux:
	@sh "$(DOTFILES)scripts/tmux.sh"

# Link configuration files
link:
	@sh "$(DOTFILES)scripts/link.sh"

# Install FiraCode and FiraMono font
fonts:
	@sh "$(DOTFILES)scripts/fonts.sh"

# Link qmk keyboards
qmk:
	@sh "$(DOTFILES)scripts/qmk.sh"

# Link css theme files for hyprland
hypr:
	@ln -s ~/.config/hypr/themes/catppuccin.css ~/.config/hypr/themes/current.css
	@ln -s ~/.cache/wal/colors-waybar.css ~/.config/hypr/themes/pywal.css

# Copy nixos configuration to ./nixos
nixos-backup:
	@cp -r /etc/nixos/* "$(DOTFILES)/nixos"
