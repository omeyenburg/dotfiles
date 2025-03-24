#!/bin/sh

# Check wifi and volume
# In eduroam and WIFI@DB volume should be muted.
network=$(nmcli -t -f NAME con show --active | head -1)

if [ "$network" = "eduroam" ] || [ "$network" = "WIFI@DB" ]; then
    if ! .config/hypr/scripts/media.sh volume get | grep -q "MUTED"; then
        ~/.config/hypr/scripts/media.sh volume toggle silent
        ~/.config/hypr/scripts/notify.sh "mute-warning" "Connected to network $network" "Volume is now muted" 4000 0 >/dev/null
    fi
fi

# Fetch new mails
if [ ! -f ~/.netrc ]; then
    echo "Missing ~/.netrc file for email notification."
    exit 1
fi

scheme=imaps
port=993

mailcache=~/.cache/seen_mails
mkdir -p ~/.cache

sed 's/ /\n/g' ~/.netrc | sed '/machine/{n;p}' -n | while read -r server; do
    url="$scheme://$server:$port/INBOX"
    mails=$(curl --url "$url" --connect-timeout 1 --netrc --request "SEARCH UNSEEN" -s | sed 's/^* SEARCH\s*//;s/\s*$//')

    for mail in $mails; do
        # Skip if already seen
        grep -q "^$mail$" "$mailcache" && continue
        echo "$mail" >>$mailcache

        subject_request="FETCH $mail (BODY.PEEK[HEADER.FIELDS (SUBJECT)])"
        subject=$(curl --url "$url" --connect-timeout 1 --netrc --request "$subject_request" -D - -s | sed -n '/^Subject:/{s/Subject:\s*//;s/\s*$//;p}')

        echo "New email: $subject"
        ~/.config/hypr/scripts/notify.sh "mail" "New mail" "$subject" 5000 1 >/dev/null
    done
done
