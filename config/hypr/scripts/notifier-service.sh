#!/bin/sh

# Check wifi and volume
# In eduroam and WIFI@DB volume should be muted.
network=$(nmcli -t -f NAME con show --active | head -1)

if [ "$network" = "eduroam" ] || [ "$network" = "WIFI@DB" ]; then
    if ! .config/hypr/scripts/media.sh volume get | grep -q "MUTED"; then
        ~/.config/hypr/scripts/media.sh volume toggle silent
        ~/.config/hypr/scripts/notify.sh "mute-warning" "Connected to network $network" "Volume is now muted" 4000 0
    fi
fi

# Fetch new mails
scheme=imaps
port=993
sed 's/ /\n/g' ~/.netrc | sed '/machine/{n;p}' -n | while read -r server; do
    mails=$(curl --url "$scheme://$server:$port/INBOX" --connect-timeout 1 --netrc --request "SEARCH UNSEEN" -s | sed 's/^* SEARCH\s*//;s/\s*$//')

    for mail in $mails; do
        subject=$(curl --url "$scheme://$server:$port/INBOX" --connect-timeout 1 --netrc --request "FETCH $mail (BODY[HEADER.FIELDS (SUBJECT)])" -D - -s | sed -n '/^Subject:/{s/Subject:\s*//;s/\s*$//;p}')
        echo "New email: $subject"
        ~/.config/hypr/scripts/notify.sh "mail" "New mail" "$subject" 5000 1
    done
done
