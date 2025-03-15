DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DOTFILES

git:
	@sh "$(DOTFILES)scripts/git.sh"

shell:
	@sh "$(DOTFILES)scripts/shell.sh"

tmux:
	@sh "$(DOTFILES)scripts/tmux.sh"

link:
	@sh "$(DOTFILES)scripts/link.sh"

unlink:
	@sh "$(DOTFILES)scripts/unlink.sh"

fonts:
	@sh "$(DOTFILES)scripts/fonts.sh"

qmk:
	@sh "$(DOTFILES)scripts/qmk.sh"

hypr:
	@sh "$(DOTFILES)scripts/make.sh"

nixos-backup:
	@sh "$(DOTFILES)scripts/nixos-backup.sh"
