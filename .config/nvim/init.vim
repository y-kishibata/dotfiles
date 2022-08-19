set number
set encoding=utf-8   " 読み込み時の文字コードの設定
scriptencoding utf-8 " Script内でマルチバイトを使う場合の設定

" bufferを切り替える時に編集中ファイルを保存しない
"set hidden

" コマンド履歴をタブで補完
set nocompatible

" 補完候補がステータスメニュー上に一覧表示
set wildmenu

" 共通部分までの補完をしつつ補完候補を表示
set wildmode=longest:full,full

" 余計なファイル拡張子を除外
set wildignore+=.git/*,*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif

" clipboard
set clipboard=unnamed

" swap
set swapfile
set directory=~/.vim/tmp

"---------------------------------
" 最後のカーソル位置を復元する
"---------------------------------
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
"---------------------------------

" from https://github.com/sinsoku/dotfiles/blob/master/vim/vimrc
"set nowrap
set ruler
set foldlevel=0
set laststatus=2
set showcmd
set showmode
set noswapfile
set autoread
set display=uhex

" visualstar
nnoremap * *<S-n>
nnoremap # #<S-n>
map * <Plug>(visualstar-*)<S-n>
map # <Plug>(visualstar-#)<S-n>

" .vimrc を編集しやすくする
"nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
"nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>
"nnoremap <C-h> :<C-u>help<Space><C-r><C-w><Enter>
"nnoremap <C-k> k

" markdown syntax
autocmd FileType md set filetype=markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Vagrantfile を Ruby シンタックスにする
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" whitespaceEOL on highlight
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", '\s\+$')
autocmd WinEnter * let w:m1 = matchadd("WhitespaceEOL", '\s\+$')

" tabstring on highlight
highlight TabString ctermbg=red guibg=red
autocmd BufWinEnter * let w:m2 = matchadd("TabString", '^\t+')
autocmd WinEnter * let w:m2 = matchadd("TabString", '^\t+')

" JpSpace on underline
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=red
autocmd BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
autocmd WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

" auto-mkdir
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
  function! s:auto_mkdir(dir)  " {{{
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" end of sinsoku

"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set fileencoding=utf-8                        " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac                  " 改行コードの自動判別. 左側が優先される
"set ambiwidth=double                         " □や○文字が崩れる問題を解決 nvimでは崩れるので無効化

"----------------------------------------------------------
" ステータスライン
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode     " 現在のモードを表示
set showcmd      " 打ったコマンドをステータスラインの下に表示
set ruler        " ステータスラインの右側にカーソルの位置を表示する

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu     " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

"----------------------------------------------------------
" タブ・ウィンドウ
"----------------------------------------------------------
set splitbelow     " 水平分割時に下に表示
set splitright     " 縦分割時を右に表示

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2  " smartindentで増減する幅

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch    " インクリメンタルサーチ. １文字入力毎に検索を行う
set noignorecase " 検索パターンに大文字小文字を区別する
"set ignorecase  " 検索パターンに大文字小文字を区別しない
set smartcase    " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch     " 検索結果をハイライト
nnoremap / /\v
vnoremap / /\v

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number                      " 行番号を表示
set cursorline                  " カーソルラインをハイライト
"highlight CursorLine ctermbg=Black
"highlight CursorLine ctermfg=Blue
" 遅い場合は、こちらに切り替える予定： https://thinca.hatenablog.com/entry/20090530/1243615055

"set cursorcolumn
"highlight CursorColumn ctermbg=Blue
"highlight CursorColumn ctermfg=Green

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <down> gj
nnoremap <silent> <up> gk

vnoremap <silent> j gj
vnoremap <silent> k gk
vnoremap <silent> <down> gj
vnoremap <silent> <up> gk

" 行が折り返し表示されていた場合でも行単位で移動する
nnoremap <C-h> ^
nnoremap <C-j> j
nnoremap <C-k> k
nnoremap <C-l> $

vnoremap <C-h> ^
vnoremap <C-j> j
vnoremap <C-k> k
vnoremap <C-l> $

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" バックスペースキーの有効化
set backspace=indent,eol,start

"----------------------------------------------------------
" visual mode 拡張
"----------------------------------------------------------
" vで行末まで選択
vnoremap v $h

"----------------------------------------------------------
" カッコ・タグの対応
"----------------------------------------------------------
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

"----------------------------------------------------------
" クリップボードからのペースト
"----------------------------------------------------------
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"----------------------------------------------------------
" Git
"----------------------------------------------------------
" commit時のコメントアウトのハイライトを変更
autocmd FileType gitcommit syntax match gitcommitComment /^[>].*/
" 修正内容を表示する
autocmd FileType gitcommit DiffGitCached | wincmd x | resize 10 | wincmd x

"----------------------------------------------------------
" ejs
"----------------------------------------------------------
autocmd BufNewFile,BufRead *.ejs set filetype=ejs
autocmd BufNewFile,BufRead *._ejs set filetype=ejs

function! s:DetectEjs()
    if getline(1) =~ '^#!.*\<ejs\>'
        set filetype=ejs
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectEjs()

" --------------------------------------------------
" 貼り付け時にペーストバッファが上書きされないようにする
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vnoremap <silent> <expr> p <sid>Repl()

"**************************************************
" <Space>* によるキーバインド設定
"**************************************************
let mapleader = "\<Space>"

"--------------------------------------------------
" 最初にヤンクした文字列を繰り返しペースト
"vnoremap <Leader>p "0p

"--------------------------------------------------
" <Leader>i でコードをインデント整形
nnoremap <Leader>i gg=<S-g><C-o><C-o>zz

"--------------------------------------------------
" <Leader>v で1行選択(\n含まず)
nnoremap <Leader>v 0v$h
nnoremap <Leader><S-v> v$h

"--------------------------------------------------
" <Leader>d で1行削除(\n含まずに dd)
nnoremap <Leader>d 0v$hx
nnoremap <Leader><S-d> v$hx

"--------------------------------------------------
" <Leader>y で改行なしで1行コピー（\n を含まずに yy）
nnoremap <Leader>y 0v$hy
nnoremap <Leader><S-y> v$hy

"--------------------------------------------------
" <Leader>s で置換
nnoremap <Leader>s :%s//
nnoremap <Leader><S-s> :s//
vnoremap <Leader>s :s//

"--------------------------------------------------
" Quit系
"--------------------------------------------------
" 閉じる処理の前段
nmap <Leader>q [quit]
nmap <Leader><S-q> [quit]

" 全部を閉じる
nnoremap <silent> [quit]q :<C-u>only<CR>:<C-u>tabo<CR>
nnoremap <silent> [quit]<S-q> :<C-u>only!<CR>:<C-u>tabo!<CR>:<C-u>q!<CR>

"--------------------------------------------------
" Window
"--------------------------------------------------
" Windowの移動
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

nmap <Leader>w [win]

nnoremap [win]h <C-w>h
nnoremap [win]j <C-w>j
nnoremap [win]k <C-w>k
nnoremap [win]l <C-w>l

" Windowを移動
nnoremap [win]a <C-w>H
nnoremap [win]s <C-w>J
nnoremap [win]d <C-w>K
nnoremap [win]f <C-w>L

nnoremap [win]<S-h> <C-w>H
nnoremap [win]<S-j> <C-w>J
nnoremap [win]<S-k> <C-w>K
nnoremap [win]<S-l> <C-w>L

" Windowの幅
nnoremap [win]e <C-w>=

nnoremap [win]<Bar> <C-w><Bar>
nnoremap [win]<S-m> <C-w><Bar>

nnoremap [win]m <C-w>_

" Windowの回転
nnoremap [win]r <C-w>r
nnoremap [win]<S-r> <C-w><S-r>

" 同一のWindow分割
nnoremap <silent> [win]<S-n> :<C-u>sp<CR><C-w>j
nnoremap <silent> [win]n :<C-u>vs<CR><C-w>l

" ウィンドウを閉じる
nnoremap <silent> [win]c :<C-u>close<CR>
nnoremap <silent> [win]x :<C-u>hide<CR>
nnoremap <silent> [quit]w :<C-u>close<CR>
nnoremap <silent> [quit]<S-w> :<C-u>only<CR>

"--------------------------------------------------
" バッファ
"--------------------------------------------------
nmap <Leader>b [bf]

nnoremap <silent> [bf]<S-N> :<C-u>new<CR><C-w>j
nnoremap <silent> [bf]n :<C-u>vnew<CR><C-w>l

nnoremap [bf]b :ls<CR>

nnoremap <silent> [bf]c :<C-u>close<CR>
nnoremap <silent> [bf]x :<C-u>hide<CR>
nnoremap <silent> [bf]d :<C-u>bd<CR>

" Buffer jump
for n in range(1, 9)
  execute 'nnoremap <silent> [bf]'.n  ':<C-u>b! '.n.'<CR>'
endfor

"--------------------------------------------------
" tabの制御
nmap <Leader>t [tab]

nnoremap <silent> tn :<C-u>tabnew<CR>
nnoremap <silent> [tab]n :<C-u>tablast <Bar> tabnew<CR>
nnoremap <silent> [tab]x :<C-u>tabclose<CR>
nnoremap <silent> [quit]t :<C-u>tabo<CR>
nnoremap <silent> [quit]<S-t> :<C-u>tabo!<CR>
nnoremap [tab]t :<C-u>tabs<CR>
nnoremap tt :<C-u>tabs<CR>

"--------------------------------------------------
" historyの制御
nmap <Leader>r [history]

nnoremap [history]h q:
nnoremap [history]l :<C-u>history<CR>
nnoremap [history]j q/
nnoremap [history]/ q/
nnoremap [history]k q?
nnoremap [history]? q?

" --------------------------------------------------
" <Leader>cd で編集ファイルのカレントディレクトリへと移動
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Leader>cd :<C-u>CD<CR>

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
"set showtabline=2 " 常にタブラインを表示

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

"----------------------------------------------------------
" マウスでカーソル移動とスクロール
"----------------------------------------------------------
if has('mouse')
  set mouse=a
endif

"===================================================
" Plugins: プラグイン管理
"===================================================
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:

call dein#add('tomasr/molokai')                         " カラースキームmolokai
call dein#add('itchyny/lightline.vim')                  " ステータスラインの表示内容強化
call dein#add('Yggdroot/indentLine')                    " インデントの可視化
call dein#add('bronson/vim-trailing-whitespace')        " 末尾の全角半角空白文字を赤くハイライト
call dein#add('scrooloose/syntastic')                   " 構文エラーチェック
call dein#add('ctrlpvim/ctrlp.vim')                     " 多機能セレクタ
call dein#add('LeafCage/yankround.vim')                 " Vimのレジスタの履歴を取って再利用する

call dein#add('tacahiroy/ctrlp-funky')                  " CtrlPの拡張プラグイン. 関数検索
call dein#add('suy/vim-ctrlp-commandline')              " CtrlPの拡張プラグイン. コマンド履歴検索
call dein#add('mattn/ctrlp-filer')                      " CtrlPの拡張プラグイン、カレントディレクトリの移動
call dein#add('nmanandhar/vim-ctrlp-menu')              " CtrlPに追加メニュー
call dein#add('rking/ag.vim')                           " CtrlPの検索にagを使う

call dein#add('pmsorhaindo/syntastic-local-eslint.vim') " プロジェクトに入ってるESLintを読み込む
call dein#add('slim-template/vim-slim')                 " slim シンタックスハイライト
call dein#add('hashivim/vim-terraform')                 " Terraform のシンタックスハイライトなど
call dein#add('juliosueiras/vim-terraform-completion')  " Terraform オムニ補完
call dein#add('~/.vim/bundle/manual')                   " apple-swift: Swfitのシンタックスハイライト
call dein#add('udalov/kotlin-vim')                      " Kotlinのシンタックスハイライト
call dein#add('nikvdp/ejs-syntax')                      " ejsのシンタックスハイライト

call dein#add('thinca/vim-visualstar')                  " ビジュアルモードで選択した文字列を検索する機能
call dein#add('scrooloose/nerdtree')                    " ディレクトリをツリー表示
call dein#add('thinca/vim-submode')                     " 繰り返し操作を登録
call dein#add("aklt/plantuml-syntax")                   " pluntumlのシンタクスハイライトと:makeコマンド
call dein#add('Shougo/neosnippet.vim')                  " スニペットの補完機能
call dein#add('Shougo/neosnippet-snippets')             " スニペット集

" マークダウンのプレビュー
"call dein#add('kazuph/previm', { 'base': 'feature/add-plantuml-plugin'})
call dein#add('tyru/open-browser.vim')

" 自動補完
call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" 下書き用の欄が出たので削除
" call dein#add('Shougo/neco-vim') " Vim用自動補完プラグイン

" Required:
call dein#end()

" Required:
" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" --------------------------------------------------
" 各種プラグインの設定
" --------------------------------------------------
" 自動更新
let g:dein#auto_recache = 1

"----------------------------------------------------------
" deoplete
"----------------------------------------------------------
" 自動補完の有効化
let g:deoplete#enable_at_startup = 1

" タブでの補完の有効化
" https://replicity.hateblo.jp/entry/2017/06/01/012535
imap <expr><TAB> pumvisible() ? "\<C-N>" : neosnippet#jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

"----------------------------------------------------------
" カラースキーム
"----------------------------------------------------------
if dein#tap('molokai')
  " https://qiita.com/kojionilk/items/67379e68cf54d811081a#colorscheme-%E3%83%86%E3%83%BC%E3%83%9E%E8%89%B2%E3%82%92%E5%A4%89%E3%81%88%E3%82%8B
  " molokai のビジュアルモードが見辛いので色を変える
  autocmd colorscheme molokai highlight Visual ctermbg=5 guibg=Grey90

  colorscheme molokai " カラースキームにmolokaiを設定する
endif

set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時に構文エラーチェックを実行する
let g:syntastic_check_on_open = 1
" 「:wq」で終了する時も構文エラーチェックする
let g:syntastic_check_on_wq = 1

" Javascript用. 構文エラーチェックにESLintを使用
let g:syntastic_javascript_checkers=['eslint']
" Javascript以外は構文エラーチェックをしない
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript'],
                           \ 'passive_filetypes': [] }

"----------------------------------------------------------
" CtrlP
"----------------------------------------------------------
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
" CtrlPの拡張として filer, funky, commandline, menu を使用
"let g:ctrlp_extensions = ['filer', 'funky', 'commandline', 'menu']
" CtrlPの拡張として filer, funky, menu を使用
let g:ctrlp_extensions = ['filer', 'funky', 'menu']
" CtrlPの拡張として filer, funky, commandline, menu を使用
"let g:ctrlp_extensions = ['filer', 'menu']

" CtrlPCommandLineの有効化
"command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

" CtrlPFunkyの絞り込み検索設定
let g:ctrlp_funky_matchtype = 'path'

if executable('ag')
  let g:ctrlp_use_caching=0 " CtrlPのキャッシュを使わない
  let g:ctrlp_user_command = 'ag %s -i --hidden -g ""' " 「ag」の検索設定
endif

" キャッシュディレクトリ
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
" キャッシュを終了時に削除しない
let g:ctrlp_clear_cache_on_exit = 0
" 遅延再描画
let g:ctrlp_lazy_update = 1
" ルートパスと認識させるためのファイル
let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml', '.vimroot']
" CtrlPのウィンドウ最大高さ
let g:ctrlp_max_height = 20
" 無視するディレクトリ
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]((\.(git|hg|svn))|(node_modules|build))$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" キーマップ変更
let g:ctrlp_map = '<C-p>'
nnoremap <silent> <C-f> :<C-u>CtrlPCurWD<CR>
let g:ctrlp_prompt_mappings = {
\ }

" Menuの定義
let g:ctrlp_use_default_menu = 0

let g:ctrlp_menus = {}
let g:ctrlp_menus.setup =
            \{
            \   "set wrap": ':set wrap',
            \   "set nowrap": ':set nowrap',
            \}

"--------------------------------------------------
" CtrlPの機能を拡張
" TODO エラーが大量で利用できないので封印
" カレントディレクトリを基準にファイルモードで検索
"nnoremap <silent> <Leader>cc :<C-u>CtrlPFiler<CR>

" カレントディレクトリを基準に検索
nnoremap <silent> <Leader>cf :<C-u>CtrlPCurWD<CR>

" カレントバッファのルートディレクトリを基準に検索(root:自動認識)
nnoremap <silent> <Leader>cp :<C-u>CtrlPRoot<CR>

" メニューを利用
nnoremap <silent> <Leader>cm :<C-u>CtrlpMenu setup<CR>

" 最近使ったファイルから検索
"nnoremap <silent> <Leader>cr :CtrlPMRUFiles<CR>

"----------------------------------------------------------
" NERdtree
"----------------------------------------------------------
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" ブックマークを初期表示
let g:NERDTreeShowBookmarks=0

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')

" 非表示ファイル
let g:NERDTreeIgnore=['\.git$', '\.clean$', '\.swp$', '\.bak$', '\~$', '__pycache__']

"----------------------------------------------------------
" yankround
"----------------------------------------------------------
nmap p <Plug>(yankround-p)
nmap <S-p> <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap g<S-p> <Plug>(yankround-gP)
nmap <S-C-n> <Plug>(yankround-prev)
nmap <C-m> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" 履歴数を調整
let g:yankround_max_history = 50

" キャッシュディレクトリを用意
let g:yankround_dir = $HOME.'/.cache/yankround'

" ハイライト
let g:yankround_use_region_hl = 1
let g:yankround_region_hl_groupname = 'YankRoundRegion'

autocmd ColorScheme *   call s:define_region_hl()
function! s:define_region_hl()
  if &bg=='dark'
    highlight default YankRoundRegion   guibg=Brown ctermbg=Brown term=reverse
  else
    highlight default YankRoundRegion   guibg=LightRed ctermbg=LightRed term=reverse
  end
endfunction

"--------------------------------------------------
" <Leader>p で履歴からペースト
nnoremap <silent> <Leader>p :<C-u>CtrlPYankRound<CR>

"----------------------------------------------------------
" submode
"----------------------------------------------------------
" submode後に即座にコマンド実行ができるように設定
let g:submode_leave_with_key = 1

"----------------------------------------------------------
" Terraform
"----------------------------------------------------------
" 保存時の自動フォーマット
let g:terraform_fmt_on_save = 1

"----------------------------------------------------------
" markdown & plantuml
"----------------------------------------------------------
"let g:previm_open_cmd = 'open -a Chrome'
nnoremap <Space><Space>p :PrevimOpen<CR>

"--------------------------------------------------
" 繰り返しの移動
"--------------------------------------------------
" Windowの移動
call submode#enter_with('win_move', 'n', '', '<C-w>w', '<C-w>w')
call submode#enter_with('win_move', 'n', '', '<Leader>[', '<C-w>w')
call submode#enter_with('win_move', 'n', '', '[win]w', '<C-w>w')
call submode#enter_with('win_move', 'n', '', '[win][', '<C-w>w')
call submode#enter_with('win_move', 'n', '', '<C-w>p', '<C-w>p')
call submode#enter_with('win_move', 'n', '', '<Leader>]', '<C-w>p')
call submode#enter_with('win_move', 'n', '', '[win]p', '<C-w>p')
call submode#enter_with('win_move', 'n', '', '[win]]', '<C-w>p')

call submode#map('win_move', 'n', '', 'w', '<C-w>w')
call submode#map('win_move', 'n', '', '[', '<C-w>w')
call submode#map('win_move', 'n', '', 'p', '<C-w>p')
call submode#map('win_move', 'n', '', ']', '<C-w>p')

" ウィンドウサイズ
call submode#enter_with('win_size', 'n', '', '[win]>', '<C-w>>')
call submode#enter_with('win_size', 'n', '', '[win]<', '<C-w><')
call submode#enter_with('win_size', 'n', '', '[win]+', '<C-w>+')
call submode#enter_with('win_size', 'n', '', '[win]-', '<C-w>-')
call submode#enter_with('win_size', 'n', '', '[win]=', '<C-w>+')
call submode#enter_with('win_size', 'n', '', '[win]_', '<C-w>-')

call submode#enter_with('win_size', 'n', '', '<Leader>>', '<C-w>>')
call submode#enter_with('win_size', 'n', '', '<Leader><', '<C-w><')
call submode#enter_with('win_size', 'n', '', '<Leader>+', '<C-w>+')
call submode#enter_with('win_size', 'n', '', '<Leader>-', '<C-w>-')
call submode#enter_with('win_size', 'n', '', '<Leader>=', '<C-w>+')
call submode#enter_with('win_size', 'n', '', '<Leader>_', '<C-w>-')

call submode#enter_with('win_size', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('win_size', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('win_size', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('win_size', 'n', '', '<C-w>-', '<C-w>-')
call submode#enter_with('win_size', 'n', '', '<C-w>=', '<C-w>+')
call submode#enter_with('win_size', 'n', '', '<C-w>_', '<C-w>-')

call submode#map('win_size', 'n', '', '>', '<C-w>>')
call submode#map('win_size', 'n', '', '<', '<C-w><')
call submode#map('win_size', 'n', '', '+', '<C-w>+')
call submode#map('win_size', 'n', '', '-', '<C-w>-')
call submode#map('win_size', 'n', '', '=', '<C-w>+')
call submode#map('win_size', 'n', '', '_', '<C-w>-')

" バッファの制御
call submode#enter_with('changebuff', 'n', '', '[bf][', ':<C-u>bnext!<CR>')
call submode#enter_with('changebuff', 'n', '', '[bf]l', ':<C-u>bnext!<CR>')
call submode#enter_with('changebuff', 'n', '', '[bf]w', ':<C-u>bnext!<CR>')
call submode#enter_with('changebuff', 'n', '', '[bf]]', ':<C-u>bprev!<CR>')
call submode#enter_with('changebuff', 'n', '', '[bf]h', ':<C-u>bprev!<CR>')
call submode#enter_with('changebuff', 'n', '', '[bf]p', ':<C-u>bprev!<CR>')

call submode#map('changebuff', 'n', '', '[', ':<C-u>bnext!<CR>')
call submode#map('changebuff', 'n', '', 'l', ':<C-u>bnext!<CR>')
call submode#map('changebuff', 'n', '', 'w', ':<C-u>bnext!<CR>')
call submode#map('changebuff', 'n', '', ']', ':<C-u>bprev!<CR>')
call submode#map('changebuff', 'n', '', 'h', ':<C-u>bprev!<CR>')
call submode#map('changebuff', 'n', '', 'p', ':<C-u>bprev!<CR>')

" Tabの制御
call submode#enter_with('changetab', 'n', '', '[tab][', 'gt')
call submode#enter_with('changetab', 'n', '', '[tab]l', 'gt')
call submode#enter_with('changetab', 'n', '', '[tab]]', 'g<S-t>')
call submode#enter_with('changetab', 'n', '', '[tab]h', 'g<S-t>')

call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'g<S-t>', 'g<S-t>')
call submode#enter_with('changetab', 'n', '', 't[', 'gt')
call submode#enter_with('changetab', 'n', '', 'tl', 'gt')
call submode#enter_with('changetab', 'n', '', 't]', 'g<S-t>')
call submode#enter_with('changetab', 'n', '', 'th', 'g<S-t>')

call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', '[', 'gt')
call submode#map('changetab', 'n', '', 'l', 'gt')
call submode#map('changetab', 'n', '', '<S-t>', 'g<S-t>')
call submode#map('changetab', 'n', '', ']', 'g<S-t>')
call submode#map('changetab', 'n', '', 'h', 'g<S-t>')

" tabの移動
call submode#enter_with('changetab', 'n', '', '[tab]<S-h>', ':<C-u>tabm -1<CR>')
call submode#enter_with('changetab', 'n', '', '[tab]<S-l>', ':<C-u>tabm +1<CR>')

call submode#map('changetab', 'n', '', '<S-h>', ':<C-u>tabm -1<CR>')
call submode#map('changetab', 'n', '', '<S-l>', ':<C-u>tabm +1<CR>')
