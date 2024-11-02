DOTFILES := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
export DOTFILES

add-conf:
	@sh "$(DOTFILES)scripts/add_conf.sh" "$(ARGS)"

configure:
	@sh "$(DOTFILES)scripts/configure.sh" "$(ARGS)"

git:
	@sh "$(DOTFILES)scripts/git.sh" "$(ARGS)"

shell:
	@sh "$(DOTFILES)scripts/shell.sh" "$(ARGS)"

tmux:
	@sh "$(DOTFILES)scripts/tmux.sh" "$(ARGS)"

link-conf:
	@sh "$(DOTFILES)scripts/link_conf.sh" "$(ARGS)"

link-home:
	@sh "$(DOTFILES)scripts/link_home.sh" "$(ARGS)"

install-wallpapers:
	@sh "$(DOTFILES)scripts/install-wallpapers.sh"
