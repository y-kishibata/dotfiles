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

# --------------------------------------------------
# Prompt設定
autoload -Uz promptinit; promptinit
prompt pure

# --------------------------------------------------
# 基本設定
## 日本語を使用
export LANG=ja_JP.UTF-8

## Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

## Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

## コマンドミスを修正
setopt correct

## ビープ音を鳴らさない
setopt nobeep

## バックグラウンドジョブが終了したらすぐに知らせる
setopt no_tify

## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

## lessのデフォルトを変更
export LESS="-iMR"

## SSHエージェント起動
ssh-add

## パスを追加したい場合
#export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# --------------------------------------------------
# キーバインドを設定
## emacsキーバインド
#bindkey -e

# viins キーマップを選択
bindkey -v

## vivs を有効にする
if [[ -s "$HOME/zsh/zsh-vimode-visual/zsh-vimode-visual.zsh" ]]; then
  source $HOME/zsh/zsh-vimode-visual/zsh-vimode-visual.zsh
fi

## home/end/deleteキーバインド
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

bindkey '^h' beginning-of-line
bindkey '^l' end-of-line

## 上下移動の追加
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search

# --------------------------------------------------
# ディレクトリ操作
## cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

## 自動でpushdを実行
setopt auto_pushd

## pushdから重複を削除
setopt pushd_ignore_dups

# --------------------------------------------------
# ヒストリー
## 他のターミナルとヒストリーを共有
setopt share_history

## ヒストリーに重複を表示しない
setopt histignorealldups

## 重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups

## historyコマンドは履歴に登録しない
setopt hist_no_store

## 余分な空白は詰めて記録
setopt hist_reduce_blanks

## `!!`を実行したときにいきなり実行せずコマンドを見せる
setopt hist_verify

# ヒストリーの補完数と保管場所
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

# --------------------------------------------------
# 補完
autoload -Uz compinit
compinit

## 補完候補表示時にビープ音を鳴らさない
setopt nolistbeep

## 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

## Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete

## 補完で大文字にもマッチ
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## 大文字小文字に関わらず, 候補が見つからない時のみ文字種を無視した補完をする
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

## cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
## cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

## 候補が多い場合は詰めて表示
setopt list_packed

## 補完に関するオプション
### http://voidy21.hatenablog.jp/entry/20090902/1251918174
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

## 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt list_types

## 補完キー連打で順に補完候補を自動で補完
setopt auto_menu

## カッコの対応などを自動的に補完
setopt auto_param_keys

## コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

## 語の途中でもカーソル位置で補完
setopt complete_in_word

## カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_last_prompt

## history の履歴検索
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco --prompt '[cmd history]'`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# --------------------------------------------------
# Env
## Set Ruby env
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi

## Set Node env
export PATH=$HOME/.nodebrew/current/bin:$PATH

## Set yarn env
export PATH="$HOME/.yarn/bin:$PATH"

## Set direnv env
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

## Set pyenv env
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# --------------------------------------------------
# OpenSSL
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

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
  local selected_dir=$(cdr -l | awk '{ print $2 }' | peco --prompt '[cdr]')
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
## 移動と一覧表示を同時に実施
function chpwd() { ls -ltrG }

function cdl () {
  builtin cd $@ && ls -G
}
function cdll () {
  builtin cd $@ && ls -ltrG
}

## ディレクトリ作成と移動を同時に行う
function mkcd () {
  mkdir -p $* && cd $_;
}

## 階層構造から選択したディレクトリに移動
function peco-child-dir-select () {
  target=`tree -d -f --noreport | grep -v 'node_modules' | peco --prompt '[select cd]' --initial-filter Fuzzy | sed 's@[│├─└  ]@@g' | awk '{ print $1 }' | xargs`
  if [ ${#target} -ne 0 ]; then
    { builtin cd $target; echo "\r\n"; __call_precmds; zle reset-prompt }
  fi
}
zle -N peco-child-dir-select
bindkey '^E' peco-child-dir-select

# --------------------------------------------------
# vim補助
function peco-child-vi-select () {
  target=`tree -f --noreport | grep -v 'node_modules' | peco --prompt '[select vi]' --initial-filter Fuzzy | sed 's@[│├─└  ]@@g' | awk '{ print $1 }' | xargs`
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


# --------------------------------------------------
# Diff系
## 色付き差分を利用する
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

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
## TODO: 相性が悪いのか途中で正しく表示されなくなるためコメントアウト
#local git==git
#branchname=`${git} symbolic-ref --short HEAD 2> /dev/null`

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

# --------------------------------------------------
# 追加設定
## 開発用などで必要になった設定を追加し、本体の設定への追加を行わない場合に追加する
if [[ -s "$HOME/.zshrc_development" ]]; then
  source "$HOME/.zshrc_development"
fi
