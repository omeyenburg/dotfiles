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

# Use imaps by default
scheme=imaps
port=993

sed 's/ /\n/g' ~/.netrc | sed '/machine/{n;p}' -n | while read -r server; do
    fetchcmd="curl -s --netrc --connect-timeout 1 --url $scheme://$server:$port/INBOX"
    mails=$($fetchcmd --request "SEARCH UNSEEN" | sed 's/^* SEARCH\s*//;s/\s*$//')

    for mail in $mails; do
        subject_request="FETCH $mail (BODY[HEADER.FIELDS (SUBJECT)])"
        subject=$($fetchcmd -D - --request "$subject_request" | sed -n '/^Subject:/{s/Subject:\s*//;s/\s*$//;p}')

        if [ "$subject" ]; then
            echo "New email: $subject"
            ~/.config/hypr/scripts/notify.sh "mail" "New mail" "$subject" 5000 1 >/dev/null
        fi
    done
done
