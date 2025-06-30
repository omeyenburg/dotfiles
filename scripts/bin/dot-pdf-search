#!/bin/sh

tmpfile=/tmp/pdfsearch
directories="$HOME/books/ $HOME/Downloads/ $HOME/git/university/"

# Search mode: "name" or "content"
mode=${1:-"name"}

if [ "$mode" = "name" ]; then
    pdfs=$(find $directories -name "*.pdf" | sed 's/\/[^\/]*\/[^\/]*\///')
    kitty --class pdfsearch sh -c "echo \"$pdfs\" | fzf --prompt='🔍 Search PDFs: ' --preview 'pdftotext -f 1 -l 2 -raw -nodiag -nopgbrk -raw {} - | head -10' > $tmpfile"
    file=$(cat $tmpfile)

    if [ -n "$file" ]; then
        zathura "$file" --fork
    fi
elif [ "$mode" = "content" ]; then
    kitty --class pdfsearch sh -c "true | fzf --prompt='🔍 Search PDFs: ' --bind \"change:reload:if [ -n {q} ]; then rga --type pdf --no-heading --color=always {q} $directories; else true; fi || true\" --ansi > $tmpfile"
    file_with_page=$(cat $tmpfile | sed 's/\(.*\.pdf\):Page \([0-9][0-9]*\): .*/\1 \2/')
    file="${file_with_page% *}"
    page="${file_with_page##* }"

    if [ -n "$file" ] && [ -n "$page" ]; then
        zathura --page="$page" "$file" --fork
    fi
else
    echo "Valid modes are: name, content."
fi
