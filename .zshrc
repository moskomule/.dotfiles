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

#history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#PATH
PATH="$HOME/anaconda/bin:$PATH"
PATH="/Applications/Julia-0.5.app/Contents/Resources/julia/bin:$PATH"
export SPARK_HOME=$HOME/local/spark/
export PATH=$PATH:$SPARK_HOME/bin
export XDG_CONFIG_HOME=$HOME/.config

#Aliases
alias ls='ls -GF'
alias la='ls -la'
alias lh='ls -lh'
alias vim='nvim'

alias py27='source activate py27'
alias py35='source deactivate py27'
alias jup='jupyter notebook'
alias tma='tmux a'

ssh-add -A >& /dev/null

[ -f ~/.zshrc_ ] && source ~/.zshrc_
