#!/bin/sh

tmpfile=/tmp/pdfsearch
pdfs=$(find ~/books/ ~/Downloads/ ~/git/university/ -name "*.pdf" | sed 's/\/[^\/]*\/[^\/]*\///')
kitty --class pdfsearch sh -c "echo \"$pdfs\" | fzf --preview 'pdftotext -f 1 -l 2 -raw -nodiag -nopgbrk -raw {} - | head -10' > $tmpfile"
cat $tmpfile | xargs -r zathura
