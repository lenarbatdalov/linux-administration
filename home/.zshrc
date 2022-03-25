# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

plugins=(git)
plugins=(vscode)

source $ZSH/oh-my-zsh.sh


# User configuration
# export LANG=en_US.UTF-8
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.bash_export ]; then
    . ~/.bash_export
fi

