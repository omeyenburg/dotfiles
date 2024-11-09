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

binary:
	@sh "$(DOTFILES)scripts/bin.sh"

wallpaper:
	@sh "$(DOTFILES)scripts/wallpaper.sh"

pywal-venv:
	@sh "$(DOTFILES)scripts/color.sh"
