# ssh
### generate
```zsh
ssh-keygen -t rsa -b 4096 -C "developer.lenar@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
```

### connection
```zsh
ssh -T git@github.com
ssh -T git@dev.cb-server.com
ssh -T git@bitbucket.org
```

### ssh + hosting
```zsh
ssh lenar@hestia.cb-server.com

ssh-copy-id lenar@hestia.cb-server.com

scp \
    start.zip \
    lenar@hestia.cb-server.com:/home/lenar/web/lenar.cbkeys.ru/public_html/backup
```
