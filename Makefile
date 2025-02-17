DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DOTFILES

configure:
	@sh "$(DOTFILES)scripts/configure.sh"

git:
	@sh "$(DOTFILES)scripts/git.sh"

shell:
	@sh "$(DOTFILES)scripts/shell.sh"

tmux:
	@sh "$(DOTFILES)scripts/tmux.sh"

link-conf:
	@sh "$(DOTFILES)scripts/link_conf.sh"

link-home:
	@sh "$(DOTFILES)scripts/link_home.sh"

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
