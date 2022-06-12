# zsh
```zsh
sudo apt install zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo chsh -s $(which zsh)

mousepad ~/.zshrc
ZSH_THEME="eastwood"

plugins=(vscode)

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='mvim'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functios ]; then
    . ~/.bash_functios
fi

if [ -f ~/.bash_export ]; then
    . ~/.bash_export
fi

source ~/.zshrc
```
