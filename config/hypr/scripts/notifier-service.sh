#!/bin/sh

# Check wifi and volume
# In eduroam and WIFI@DB volume should be muted.
network=$(nmcli -t -f NAME con show --active | head -1)

if [ "$network" = "eduroam" ] || [ "$network" = "WIFI@DB" ]; then
    if ! ~/.local/bin/dot-media volume get | grep -q "MUTED"; then
        ~/.local/bin/dot-media volume toggle silent
        ~/.local/bin/dot-notify "mute-warning" "Connected to network $network" "Volume is now muted" 4000 0 >/dev/null
    fi
fi

# Fetch new mails
if [ ! -f ~/.netrc ]; then
    echo "Missing ~/.netrc file for email notification."
    exit 1
fi

# Do not send notifications if thunderbird is running,
# thunderbird will send notifications itself.
silent=$(pgrep thunderbird)

# Assume imaps scheme and port 993, might not work for all mail clients.
scheme=imaps
port=993

decode() {
    string=$1
    python_decode="import sys; from email.header import decode_header; print(''.join(str(t[0], t[1] or 'utf-8') if isinstance(t[0], bytes) else t[0] for t in decode_header(sys.stdin.read().strip())))"
    echo "$string" | python3 -c "$python_decode"
    return 0
}

mailcache=~/.cache/mails
mkdir -p "$mailcache"

sed 's/ /\n/g' ~/.netrc | sed '/machine/{n;p}' -n | while read -r server; do
    url="$scheme://$server:$port/INBOX"
    mails=$(curl --url "$url" --connect-timeout 1 --netrc --request "SEARCH UNSEEN" -s | sed 's/^* SEARCH\s*//;s/\s*$//')

    for mail in $mails; do
        # Skip if already seen
        grep -q "^$mail$" "$mailcache/$server" && continue
        echo "$mail" >>"$mailcache/$server"

        if ("$silent"); then
            continue
        fi

        request="FETCH $mail (BODY.PEEK[HEADER.FIELDS (FROM TO SUBJECT)])"
        response=$(curl --url "$url" --connect-timeout 1 --netrc --request "$request" -D - -s)

        from=$(echo "$response" | sed -n '/^From:\s*/{s///;s/\s*$//;p}')
        to=$(echo "$response" | sed -n '/^To:\s*/{s///;s/\s*$//;p}')
        subject=$(echo "$response" | sed -n '/^Subject:\s*/{s///;s/\s*$//;p}')

        decoded_from=$(decode "$from" | sed "s/[^<>]* <\([^ ]*\)>/\1/")
        decoded_to=$(decode "$to" | sed "s/[^<>]* <\([^ ]*\)>/\1/")
        decoded_subject=$(decode "$subject")

        notification=$(printf "By: %s\nTo: %s\n" "$decoded_from" "$decoded_to")
        ~/.local/bin/dot-notify "mail" "$decoded_subject" "$notification" 5000 0 >/dev/null
    done
done
