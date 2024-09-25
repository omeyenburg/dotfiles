line = '  tmux set-option -g pane-border-style "fg=${gray}"'
with open('.config/tmux/plugins/tmux-dracula/scripts/dracula.sh', 'r+') as f:
    content = f.read()
    f.seek(0)
    f.write(content.replace(line, ''))
    f.truncate()
