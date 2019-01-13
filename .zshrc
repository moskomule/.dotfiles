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

# custom path
[ -f ~/.zshrc_ ] && source ~/.zshrc_

# Aliases
alias ls='ls -GF'
alias la='ls -la'
alias lh='ls -lh'
alias jup='jupyter lab'
alias tma='tmux a'

if (( $+commands[nvim] )); then
    alias vim='nvim'
fi

if (( $+commands[bat] )); then
    alias cat='bat'
fi

if (( $+commands[exa] )); then
    alias ls='exa --git'
fi

# functions
mc(){
    mkdir $1
    cd $1
    echo `pwd`
}

if (( $+commands[peco] )); then
    alias -g P='| peco'
    function peco-select-history() {
        BUFFER=$(fc -l -r -n 1 | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle redisplay
    }
    zle -N peco-select-history
    bindkey '^r' peco-select-history
    
    function peco-src() {
        local selected_dir=$(ghq list | peco --query "$LBUFFER")
        if [ -n "$selected_dir" ]; then
            BUFFER="cd ${HOME}/.ghq/${selected_dir}"
            zle accept-line
        fi
        zle redisplay
    }
    zle -N peco-src
    bindkey '^g' peco-src
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

fpath=(/usr/local/share/zsh-completions $fpath)
source $(brew --prefix)/opt/zsh-autosuggestions/share/zsh-autosuggestions
# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

