set number
set encoding=utf-8
scriptencoding utf-8
" ↑1行目は読み込み時の文字コードの設定
" ↑2行目はVim Script内でマルチバイトを使う場合の設定
" Vim scritptにvimrcも含まれるので、日本語でコメントを書く場合は先頭にこの設定が必要になる

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

"----------------------------------------------------------
" NeoBundle
"----------------------------------------------------------
if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

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

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
" カラースキームmolokai
NeoBundle 'tomasr/molokai'
" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
" インデントの可視化
NeoBundle 'Yggdroot/indentLine'
" 末尾の全角半角空白文字を赤くハイライト
NeoBundle 'bronson/vim-trailing-whitespace'
" 構文エラーチェック
NeoBundle 'scrooloose/syntastic'
" 多機能セレクタ
NeoBundle 'ctrlpvim/ctrlp.vim'
" Vimのレジスタの履歴を取って再利用する
NeoBundle 'LeafCage/yankround.vim'
" CtrlPの拡張プラグイン. 関数検索
NeoBundle 'tacahiroy/ctrlp-funky'
" CtrlPの拡張プラグイン. コマンド履歴検索
"NeoBundle 'suy/vim-ctrlp-commandline'
" CtrlPの拡張プラグイン、カレントディレクトリの移動
NeoBundle 'mattn/ctrlp-filer'
" CtrlPに追加メニュー
NeoBundle 'nmanandhar/vim-ctrlp-menu'
" CtrlPの検索にagを使う
NeoBundle 'rking/ag.vim'
" プロジェクトに入ってるESLintを読み込む
NeoBundle 'pmsorhaindo/syntastic-local-eslint.vim'
" slim シンタックスハイライト
NeoBundle 'slim-template/vim-slim'
" Terraform のシンタックスハイライトなど
NeoBundle 'hashivim/vim-terraform'
" Terraform オムニ補完
NeoBundle 'juliosueiras/vim-terraform-completion'
" Swfitのシンタックスハイライト
"NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'apple-swift', {'type': 'nosync', 'base': '~/.vim/bundle/manual'}
" Kotlinのシンタックスハイライト
NeoBundle 'udalov/kotlin-vim'
" ejsのシンタックスハイライト
NeoBundle 'nikvdp/ejs-syntax'
" ビジュアルモードで選択した文字列を検索する機能
NeoBundle 'thinca/vim-visualstar'
" ディレクトリをツリー表示
NeoBundle 'scrooloose/nerdtree'
" 繰り返し操作を登録
NeoBundle 'kana/vim-submode'

" vimのlua機能が使える時だけ以下のVimプラグインをインストールする
if has('lua')
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle "Shougo/neosnippet"
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif

call neobundle#end()

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck

"----------------------------------------------------------
" カラースキーム
"----------------------------------------------------------
if neobundle#is_installed('molokai')
  " https://qiita.com/kojionilk/items/67379e68cf54d811081a#colorscheme-%E3%83%86%E3%83%BC%E3%83%9E%E8%89%B2%E3%82%92%E5%A4%89%E3%81%88%E3%82%8B
  " molokai のビジュアルモードが見辛いので色を変える
  autocmd colorscheme molokai highlight Visual ctermbg=5 guibg=Grey90

  colorscheme molokai " カラースキームにmolokaiを設定する
endif

set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

"----------------------------------------------------------
" ステータスライン
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの位置を表示する

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=2 " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2 " smartindentで増減する幅

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set noignorecase " 検索パターンに大文字小文字を区別する
"set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
nnoremap / /\v

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト
"highlight CursorLine ctermbg=Black
"highlight CursorLine ctermfg=Blue
" 遅い場合は、こちらに切り替える予定： https://thinca.hatenablog.com/entry/20090530/1243615055

"set cursorcolumn
"highlight CursorColumn ctermbg=Blue
"highlight CursorColumn ctermfg=Green

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" 行が折り返し表示されていた場合でも行単位で移動する
nnoremap <C-h> b
nnoremap <C-j> j
nnoremap <C-k> k
nnoremap <C-l> w

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" バックスペースキーの有効化
set backspace=indent,eol,start

"----------------------------------------------------------
" カッコ・タグの対応
"----------------------------------------------------------
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

"----------------------------------------------------------
" マウスでカーソル移動とスクロール
"----------------------------------------------------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

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
" neocomplete・neosnippetの設定
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

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

"----------------------------------------------------------
" Terraform
"----------------------------------------------------------
" 保存時の自動フォーマット
let g:terraform_fmt_on_save = 1


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
vmap <silent> <expr> p <sid>Repl()

"**************************************************
" <Space>* によるキーバインド設定
"**************************************************

let mapleader = "\<Space>"

"--------------------------------------------------
" 最初にヤンクした文字列を繰り返しペースト
"vnoremap <Leader>p "0p

"--------------------------------------------------
" <Leader>p で履歴からペースト
nnoremap <silent> <Leader>p :<C-u>CtrlPYankRound<CR>

"--------------------------------------------------
" <Leader>i でコードをインデント整形
map <Leader>i gg=<S-g><C-o><C-o>zz

"--------------------------------------------------
" <Leader>v で1行選択(\n含まず)
noremap <Leader>v 0v$h
noremap <Leader><S-v> v$h

"--------------------------------------------------
" <Leader>d で1行削除(\n含まずに dd)
noremap <Leader>d 0v$hx
noremap <Leader><S-d> v$hx

"--------------------------------------------------
" <Leader>y で改行なしで1行コピー（\n を含まずに yy）
noremap <Leader>y 0v$hy
noremap <Leader><S-y> v$hy

"--------------------------------------------------
" <Leader>s で置換
noremap <Leader>s :%s//
noremap <Leader><S-s> :s//

"--------------------------------------------------
" CtrlPの機能を拡張
" カレントディレクトリを基準にファイルモードで検索
nnoremap <silent> <Leader>cc :CtrlPFiler<CR>

" カレントディレクトリを基準に検索
nnoremap <silent> <Leader>cf :CtrlPCurWD<CR>

" カレントバッファのルートディレクトリを基準に検索(root:自動認識)
nnoremap <silent> <Leader>cp :CtrlPRoot<CR>

" メニューを利用
nnoremap <silent> <Leader>cm :CtrlpMenu setup<CR>

" 最近使ったファイルから検索
"nnoremap <silent> <Leader>cr :CtrlPMRUFiles<CR>

"--------------------------------------------------
" Window
"--------------------------------------------------
" Windowの移動
noremap <Leader>[ <C-w>w
noremap <Leader>] <C-w>p

noremap <Leader>h <C-w>h
noremap <Leader>j <C-w>j
noremap <Leader>k <C-w>k
noremap <Leader>l <C-w>l

nmap <Leader>w [window]
noremap [window]h <C-w>h
noremap [window]j <C-w>j
noremap [window]k <C-w>k
noremap [window]l <C-w>l

" Windowを移動
noremap [window]a <C-w>H
noremap [window]s <C-w>J
noremap [window]d <C-w>K
noremap [window]f <C-w>L

noremap [window]<S-h> <C-w>H
noremap [window]<S-j> <C-w>J
noremap [window]<S-k> <C-w>K
noremap [window]<S-l> <C-w>L

" Windowの幅
noremap [window]< <C-w><
noremap [window]- <C-w>-
noremap [window]+ <C-w>+
noremap [window]> <C-w>>

noremap [window]= <C-w>=
noremap [window]e <C-w>=

noremap [window]<Bar> <C-w><Bar>
noremap [window]<S-m> <C-w><Bar>

noremap [window]_ <C-w><Bar>
noremap [window]m <C-w>_

" 繰り返しで幅変更ができるように調整
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

" Windowの回転
noremap [window]r <C-w>r
noremap [window]<S-r> <C-w><S-r>

" 同一のWindow分割
noremap <silent> [window]<S-n> :sp<CR>
noremap <silent> [window]n :vs<CR>

" ウィンドウを閉じる
noremap <silent> [window]q :close<CR>
noremap <silent> [window]x :hide<CR>
noremap <silent> [window]o :only<CR>

"--------------------------------------------------
" バッファ
"--------------------------------------------------
" バッファの制御
nmap <Leader>b [buffer]
noremap <silent> [buffer]<S-N> :new<CR>
noremap <silent> [buffer]n :vnew<CR>

noremap [buffer]b :ls<CR>

noremap <silent> [buffer]q :close<CR>
noremap <silent> [buffer]x :hide<CR>
noremap <silent> [buffer]o :only<CR>

noremap <silent> [buffer][ :bprev!<CR>
noremap <silent> [buffer]] :bnext!<CR>

noremap <silent> [buffer]h :bprev!<CR>
noremap <silent> [buffer]l :bnext!<CR>

noremap <silent> [buffer]j :blast!<CR>
noremap <silent> [buffer]k :bfirst!<CR>

" Buffer jump
for n in range(1, 9)
  execute 'nnoremap <silent> [buffer]'.n  ':<C-u>b! '.n.'<CR>'
endfor

"--------------------------------------------------
" tabの制御
map <Leader>t [tab]
"noremap [tab]n :tabnew<CR>
noremap <silent> [tab]n :tablast <Bar> tabnew<CR>
noremap <silent> [tab]x :tabclose<CR>
noremap <silent> [tab]q :tabo<CR>
noremap [tab]t :tabs<CR>
noremap tt :tabs<CR>

noremap [tab][ gt
noremap [tab]l gt
noremap [tab]] g<S-t>
noremap [tab]h g<S-t>
noremap t[ gt
noremap tl gt
noremap t] g<S-t>
noremap th g<S-t>

"--------------------------------------------------
" historyの制御
map <Leader>r [history]
noremap [history]r q:
noremap [history]h :history<CR>

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
