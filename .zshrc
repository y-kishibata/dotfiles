fpath=( "$HOME/.zfunctions" $fpath )

autoload -U promptinit; promptinit
prompt pure

# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8

# SSHエージェント起動
ssh-add

# lessのデフォルトを変更
export LESS="-iMR"

# 色付き差分を利用する
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# パスを追加したい場合
#export PATH="$HOME/bin:$PATH"

# 補完
autoload -Uz compinit
compinit

# emacsキーバインド
#bindkey -e

# viins キーマップを選択
bindkey -v

# home/end/deleteキーバインド
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# 上下移動の追加
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search

# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

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
alias vd='vimdiff'

alias l='ls -G'
alias ls='ls -G'
alias la='ls -aG'
alias lar='ls -arG'
alias lr='ls -rG'
alias ltr='ls -trG'
alias ll='ls -lG'
alias lll='ls -lG'
alias lla='ls -laG'
alias llar='ls -larG'
alias llr='ls -lrG'
alias lltr='ls -ltrG'

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

# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete

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

# Gitエイリアス
alias g='git'
alias gs='git status'
alias gf='git fetch --prune'
alias gp='git pull'
alias gb='git branch'
alias gbr='git branch --remote'
alias gd='git diff'
alias gdc='git diff --cached'

# 絵文字
source ~/zsh/emoji-cli/emoji-cli.zsh

# 絵文字設定
EMOJI_CLI_KEYBIND=^s

# AWSエイリアス
alias aws-identity="aws sts get-caller-identity"
alias aws-whoami="aws sts get-caller-identity --output text --query Arn"

function aws-reset() {
  unset TF_WORKSPACE
  unset ASSUME_ROLE_ARN
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  direnv reload;
}


# Terraformエイリアス
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfpl="terraform plan | landscape"
alias tfa="terraform apply"
alias tfss="terraform state show"
alias tfsl="terraform state list"

# Github cli
eval "$(hub alias -s)"
export PATH="/usr/local/sbin:$PATH"

# --------------------------------------------------
# Ctrl-Zを使ってVimにスイッチバックする
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
