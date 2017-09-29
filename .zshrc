bindkey -e
setopt nonomatch # no nomatch error for sth like [x]
autoload -U compinit; compinit
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_cd
setopt share_history
setopt extended_glob
setopt prompt_subst
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt complete_aliases
disable r # use ctrl+r instead

# history
export HISTFILE=${HOME}/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
setopt EXTENDED_HISTORY

# PATH
export PATH=$PATH:${HOME}/.dotfiles/scripts
export XDG_CONFIG_HOME=$HOME/.config

# Aliases
alias ls='ls -GF'
alias la='ls -la'
alias lh='ls -lh'
alias vim='nvim'

# functions
mc(){
    mkdir $1
    cd $1
    echo `pwd`
}

alias jup='jupyter notebook'
alias tma='tmux a'

[ -f ~/.zshrc_ ] && source ~/.zshrc_
