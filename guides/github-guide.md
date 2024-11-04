# Github SSH
To use Github properly you might want to create an ssh key.

## Generate a key with ed25519
```
ssh-keygen -t ed25519 -C "135001586+omeyenburg@users.noreply.github.com"
```

## Add the SSH key to the SSH agent
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

## Copy the public key and paste it in [Github](https://github.com/settings/keys)
```
cat ~/.ssh/id_ed25519.pub
```

## Verify connection
```
ssh -T git@github.com
```
