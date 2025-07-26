#!/usr/bin/env bash

append() {
    # arg1: file
    # arg2: content

    (
        source scripts/err.sh
        source scripts/exists.sh

        SCRIPT_NAME="append.sh"

        start="# Start of automatically generated dotfiles section #"
        end="# End of automatically generated dotfiles section #"

        file="$1"
        content="$2"

        if [ ! "$file" ]; then
            err "No file provided."
        fi
        if [ ! "$content" ]; then
            err "No content provided."
        fi

        echo "Check if $file already exists..."
        if [ -e "$file" ]; then
            echo "File already exists."
            sed -i "/$start/,/$end/d" "$file"

            if [ -s "$file" ] && [ "$(tail -n1 "$file")" ]; then
                echo "" >>"$file" || err "Failed to write."
            fi
        else
            echo "File will be created."
            touch $file || err "Could not create file $file."
        fi

        echo "Writing content..."

        echo "$start" >>"$file"
        echo "" >>"$file"
        echo "$content" >>"$file"
        echo "" >>"$file"
        echo "$end" >>"$file"

        echo "Successfully wrote content into $file."
    )
}
