## rbenv
export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
eval "$(rbenv init - zsh)"

## vim
alias vi='/usr/local/bin/vim'
alias vim='/usr/local/bin/vim'

## add dir command
alias up='..'
alias 1up='..'
alias 2up='cd ../..'
alias 3up='cd ../../..'
alias 4up='cd ../../../..'

## add git command
alias g='git'
alias gs='git status'
alias gch='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch'
alias gbr='git branch -r'

### add

autoload -U promptinit; promptinit
prompt pure

# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8

# SSHエージェント起動
ssh-add

# パスを追加したい場合
#export PATH="$HOME/bin:$PATH"

# 補完
autoload -Uz compinit
compinit

# emacsキーバインド
#bindkey -e
# viins キーマップを選択
bindkey -v

# home/endキーバインド
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
# setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct

# Set Postgresql
#export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"
#export PATH="/usr/local/opt/postgrs/bin:$PATH"

## Set Ruby env
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

## Set Node env
export PATH=$HOME/.nodebrew/current/bin:$PATH

## Set yarn env
export PATH="$HOME/.yarn/bin:$PATH"

## Set direnv env
eval "$(direnv hook zsh)"


# エイリアス
alias vi='vim'

alias l='ls -G'
alias ls='ls -G'
alias la='ls -laG'
alias ll='ls -lG'
alias lll='ls -lG'

alias up='cd ../'
alias 1up='cd ../'
alias 2up='cd ../../'
alias 3up='cd ../../../'
alias 4up='cd ../../../../'
alias 5up='cd ../../../../../'

alias findline='find . -type f | xargs grep . | grep '

alias tree='tree -N'
alias treed='tree -N -d'
alias lsd='ls -F | grep /'
alias lld='ll -F | grep /'

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control


# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 大文字小文字に関わらず, 候補が見つからない時のみ文字種を無視した補完をする
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
# cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

# history の対応
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# git設定
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# エイリアス
alias g='git'
alias gs='git status'
alias gf='git fetch -p'
alias gp='git pull'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'

# 絵文字
source ~/zsh/emoji-cli/emoji-cli.zsh

# 絵文字設定
EMOJI_CLI_KEYBIND=^s

