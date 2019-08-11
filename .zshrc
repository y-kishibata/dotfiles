#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

fpath=( "$HOME/.zfunctions" $fpath )

# vivs を有効にする
if [[ -s "$HOME/zsh/zsh-vimode-visual/zsh-vimode-visual.zsh" ]]; then
  source $HOME/zsh/zsh-vimode-visual/zsh-vimode-visual.zsh
fi

autoload -Uz promptinit; promptinit
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

bindkey '^h' beginning-of-line
bindkey '^l' end-of-line

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

# 重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# `!!`を実行したときにいきなり実行せずコマンドを見せる
setopt hist_verify

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

# ビープ音を鳴らさない
setopt nobeep

# バックグラウンドジョブが終了したらすぐに知らせる
setopt no_tify

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# 補完候補表示時にビープ音を鳴らさない
setopt nolistbeep

# --------------------------------------------------
# Env
## Set Ruby env
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

## Set Node env
export PATH=$HOME/.nodebrew/current/bin:$PATH

## Set yarn env
export PATH="$HOME/.yarn/bin:$PATH"

## Set direnv env
eval "$(direnv hook zsh)"

# --------------------------------------------------
# cdr の設定
autoload -Uz is-at-least
if is-at-least 4.3.11; then
  # cdr, add-zsh-hook を有効にする
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs

  # cdr の設定
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':completion:*' recent-dirs-insert both
  if [ ! -e "$HOME/.cache/chpwd-recent-dirs" ]; then
    touch "$HOME/.cache/chpwd-recent-dirs"
  fi
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# https://wada811.blogspot.com/2014/09/zsh-cdr.html
function peco-cdr() {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
  if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
  fi
  # zle clear-screen
}
zle -N peco-cdr
bindkey '^D' peco-cdr

# --------------------------------------------------
# autojump
BREW_PREFIX=`brew --prefix`
if [ -s "$BREW_PREFIX/etc/autojump.sh" ]; then
  source "$BREW_PREFIX/etc/autojump.sh"

  # cd時に履歴を保管するように修正
  function precmd_savedir () {
      pwd=`pwd`
      autojump -a $pwd
      echo $pwd > $HOME/.curdir
  }
else
  # cd時に履歴を保管するように修正
  function precmd_savedir () {
      pwd=`pwd`
      echo $pwd > $HOME/.curdir
  }
fi
add-zsh-hook precmd precmd_savedir

# ターミナルを開いた際に最後のディレクトリを強制する
cd `cat $HOME/.curdir`

# --------------------------------------------------
# CD系の操作
# 移動と一覧表示を同時に実施
function cdl () {
  builtin cd && ls
}
function cdll () {
  builtin cd && ls -ltr
}

# 階層構造から選択したディレクトリに移動
function peco-child-dir-select () {
  target=`tree -d -f --noreport | peco | sed 's@[│├─└  ]@@g' | awk '{ print $1 }' | xargs`
  if [ ${#target} -ne 0 ]; then
    { builtin cd $target; echo "\r\n"; __call_precmds; zle reset-prompt }
  fi
}
zle -N peco-child-dir-select
bindkey '^E' peco-child-dir-select

# --------------------------------------------------
# vim補助
function peco-child-vi-select () {
  target=`tree -f --noreport | peco | sed 's@[│├─└  ]@@g' | awk '{ print $1 }' | xargs`
  if [ ${#target} -ne 0 ]; then
    echo ${target} | xargs start vim
    zle reset-prompt
  fi
}
zle -N peco-child-vi-select
bindkey '^G' peco-child-vi-select

# --------------------------------------------------
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

alias ccd='cd ~'
alias cdd='cd ~'
alias cdh='cd ~'

alias up='cd ../'
alias 1up='cd ../'
alias 2up='cd ../../'
alias 3up='cd ../../../'
alias 4up='cd ../../../../'
alias 5up='cd ../../../../../'

alias relogin='exec $SHELL -l'

alias findline='find . -type f | xargs grep . | grep '

alias tree='tree -N'
alias treed='tree -N -d'
alias lsd='ls -F | grep /'
alias lsda='ls -aF | grep /'
alias lld='ls -lF | grep /'
alias llda='ls -laF | grep /'

alias aj='autojump'
alias ajs='autojump --stat'
alias ajl='autojump --complete'
alias ajp='autojump --purge'

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

# --------------------------------------------------
# Git系設定
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

# branch名取得の高速化
## ref: https://qiita.com/yaotti/items/0af5d50f4f52d22a46fe
local git==git
branchname=`${git} symbolic-ref --short HEAD 2> /dev/null`

# Github cli
eval "$(hub alias -s)"
## ショートカットのタブ補完が効かないので保留
# function git(){hub "$@"}
# export PATH="/usr/local/sbin:$PATH"

# Gitエイリアス
alias g='git'
alias gs='git status'
alias gf='git fetch --prune'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gb='git branch'
alias gbr='git branch --remote'
alias gd='git diff'
alias gdc='git diff --cached'

# --------------------------------------------------
# 絵文字
if [[ -s "$HOME/zsh/emoji-cli/emoji-cli.zsh" ]]; then
  source $HOME/zsh/emoji-cli/emoji-cli.zsh

  # 絵文字設定
  EMOJI_CLI_KEYBIND=^s
fi

# --------------------------------------------------
# enhancd
if [[ -s "$HOME/zsh/enhancd/init.sh" ]]; then
  source $HOME/zsh/enhancd/init.sh
fi

# --------------------------------------------------
# AWSエイリアス
alias aws-identity="aws sts get-caller-identity"
alias aws-whoami="aws sts get-caller-identity --output text --query Arn"

function aws-reset() {
  unset TF_WORKSPACE
  unset AWS_SDK_LOAD_CONFIG
  unset AWS_DEFAULT_PROFILE
  unset AWS_PROFILE
  unset ASSUME_ROLE_ARN
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  direnv reload;
}

function aws-env() {
  echo "TF_WORKSPACE=$TF_WORKSPACE"
  echo "AWS_SDK_LOAD_CONFIG=$AWS_SDK_LOAD_CONFIG"
  echo "AWS_DEFAULT_PROFILE=$AWS_DEFAULT_PROFILE"
  echo "AWS_PROFILE=$AWS_PROFILE"
  echo "ASSUME_ROLE_ARN=$ASSUME_ROLE_ARN"
  echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
  echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
  echo "AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN"
}

# --------------------------------------------------
# Terraformエイリアス
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfpl="terraform plan | landscape"
alias tfa="terraform apply"
alias tfss="terraform state show"
alias tfsl="terraform state list"

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
