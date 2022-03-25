# terminal
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias autoremove='sudo apt autoremove'
alias autoclean='sudo apt autoclean'
alias search='apt-cache search'
alias q='exit'
alias c='clear'
alias h='history'
alias www='cd /var/www/html'
alias l='ls'

# bash скрипты
alias bastatus='cd /var/www/html/base && git status'
alias bapull='cd /var/www/html/base && git pull origin master'
alias bacommit='cd /var/www/html/base && git commit -m'
alias bapush='cd /var/www/html/base && git push origin master'

# git
alias st='git status'
alias com='git add . && git commit'
alias pull='git pull origin'
alias pullm='git pull origin master'
alias push='git push origin'
alias pushm='git push origin master'
alias resetfile='git checkout HEAD --'

# composer
alias compi='composer install'
alias compu='composer update'
alias compr='composer require'
alias compc='composer create-project'

# symfony
alias scliserv='symfony server:start --no-tls'

# docker
alias dcb='docker-compose build'
alias dcup='docker-compose up -d'
alias dcd='docker-compose down'
alias dps='docker ps'

# алиасы на функции, ф-ции смотреть в .bash_functions
alias dex='dockerExecBash'

alias che='git checkout'
alias sopr='source ~/.profile'
alias alist='apt list --upgradable'
alias hosts="sudo gedit /etc/hosts"
alias dir-nginx="cd /etc/nginx/"
