lines = (
    (
        '  tmux set-option -g pane-border-style "fg=${gray}"',
        "",
    ),
    (
        '"#[fg=${gray},bg=${dark_purple}]${left_sep}#[fg=${white},bg=${dark_purple}] #I #W${current_flags} #[fg=${dark_purple},bg=${gray}]${left_sep}"',
        '"#[fg=${gray},bg=${dark_purple}]${left_sep}#[fg=${gray},bg=${dark_purple}] #I #W${current_flags} #[fg=${dark_purple},bg=${gray}]${left_sep}"',
    ),
    (
        '"#[fg=${white},bg=${dark_purple}] #I #W${current_flags} "',
        '"#[fg=${gray},bg=${dark_purple}] #I #W${current_flags} "',
    ),
)

try:
    with open(".config/tmux/plugins/tmux-dracula/scripts/dracula.sh", "r+") as f:
        content = f.read()

        for line in lines:
            content = content.replace(line[0], line[1])

        f.seek(0)
        f.write(content)
        f.truncate()
except FileNotFoundError:
    print(
        "Could not find dracula tmux plugin. Perhaps it is not installed in .config/tmux/plugins?"
    )
