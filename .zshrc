bindkey -e
setopt nonomatch # no nomatch error for sth like [x]
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_cd
setopt share_history
setopt extended_glob
setopt prompt_subst

#PATH
PATH="/Users/mosko/anaconda/bin:$PATH"
PATH="/Applications/Julia-0.5.app/Contents/Resources/julia/bin:$PATH"
export SPARK_HOME=/Users/mosko/Documents/spark
export PATH=$PATH:$SPARK_HOME/bin

#Aliases
alias la='ls -la'
alias lh='ls -lh'
alias vim='nvim'

alias zeppelin='$SPARK_HOME/zeppelin/bin/zeppelin-daemon.sh'
alias py27='source activate py27'

alias chrome='open /Applications/Google\ Chrome.app'
alias mysql='/Applications/XAMPP/bin/mysql'

source $HOME/.ssh/connections
ssh-add -A >& /dev/null
