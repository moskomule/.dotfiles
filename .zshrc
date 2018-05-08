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
setopt hist_ignore_all_dups
export HISTSIZE=10000
export SAVEHIST=10000
setopt EXTENDED_HISTORY

# PATH
export PATH="$HOME/.miniconda/bin:$PATH"
export PATH="$PATH:${HOME}/.dotfiles/scripts"
export XDG_CONFIG_HOME=${HOME}/.dotfiles

# see http://www.sirochro.com/note/terminal-zsh-prompt-customize/
# VCSの情報を取得するzsh関数
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }
#PROMPT='%{$fg[red]%}%n%{$reset_color%}'
PROMPT='%n'
PROMPT=$PROMPT'${vcs_info_msg_0_}%{${fg[red]}%}%}%{${reset_color}%}%# '

# Aliases
alias ls='ls -GF'
alias la='ls -la'
alias lh='ls -lh'
alias setpythonpath='export PYTHONPATH=$(pwd)'
alias jup='jupyter lab'
alias tma='tmux a'
if hash nvim 2>/dev/null; then
    alias vim='nvim'
fi

# functions
mc(){
    mkdir $1
    cd $1
    echo `pwd`
}


# load custom setting
[ -f ~/.zshrc_ ] && source ~/.zshrc_

