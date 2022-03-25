# terminal
alias h='history'
alias www='cd /srv/http/'
alias sopr='source ~/.zshrc' # && source ~/.tmux.conf'

# git
alias st='git status'
alias com='git add . && git commit'
alias pull='git pull origin'
alias pullm='git pull origin master'
alias push='git push origin'
alias pushm='git push origin master'
alias resetfile='git checkout HEAD --'
alias che='git checkout'

# composer
alias compi='composer install'
alias compu='composer update'
alias compr='composer require'
alias compc='composer create-project'

# symfony
alias scliserv='symfony server:start --no-tls'

# laravel
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

# docker
alias dcb='docker-compose build'
alias dcup='docker-compose up -d'
alias dcd='docker-compose down'
alias dps='docker ps'
alias dpsf="docker ps --format 'table {{.Names}}\t{{.Ports}}'"
alias ctop='docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'

# алиасы на функции, ф-ции смотреть в .bash_functions
alias dex='dockerExecBash'
alias desh='dockerExecSh'

# tmux
alias tx-new='tmux new-session -s losst'
alias tx-help='
    echo "Разделение окнана панели:" && \
    echo "    - по горизонтали Ctrl+b отпустить, затем Shift+\"" && \
    echo "    - по вертикали Ctrl+b, затем Shift+%" && \
    echo "Переключение между панелями Ctrl+b и стрелка" && \
    echo "Размер активной панели можно менять нажав Ctrl+b, потом Ctrl и стрелка"'
