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

#PATH
PATH="$HOME/anaconda/bin:$PATH"
PATH="/Applications/Julia-0.5.app/Contents/Resources/julia/bin:$PATH"
export PATH=$PATH:$SPARK_HOME/bin
export SPARK_HOME=/Users/mosko/Documents/spark

#Aliases
alias ls='ls -GF'
alias la='ls -la'
alias lh='ls -lh'
alias vim='nvim'

alias zeppelin='$SPARK_HOME/zeppelin/bin/zeppelin-daemon.sh'
alias py27='source activate py27'
alias py35='source deactivate py27'

alias chrome='open /Applications/Google\ Chrome.app'
alias mysql='/Applications/XAMPP/bin/mysql'

ssh-add -A >& /dev/null

[ -f ~/.zshrc_ ] && source ~/.zshrc_
