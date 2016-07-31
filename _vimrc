"---------------------------------------------------------------------------
" NeoBundle(プラグイン)
"
let $plugin_base_path = expand('~/dotfiles/vimfiles/bundle/')

if has('vim_starting')
  set nocompatible

  " NeoBundleが無ければ、(ディレクトリ作ってから、)Gitから取得する
  let $neobundle_path = $plugin_base_path.'neobundle.vim'
  if !isdirectory($neobundle_path)
    call system('mkdir '.shellescape($plugin_base_path))
    call system('git clone https://github.com/Shougo/neobundle.vim.git '.shellescape($neobundle_path))
  endif

  set runtimepath+=$neobundle_path
endif

call neobundle#begin($plugin_base_path)


" NeoBundle ***
"

" 自分自身を管理する
NeoBundleFetch 'Shougo/neobundle.vim'


" vimfiler ***
"
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

" キーマッピング
"   vimfilerをIDE風(左:ファイルペイン/右:ファイルコンテンツペイン)に開く
nnoremap <silent> <Space>fi :VimFilerBufferDir -split -simple -winwidth=45 -no-quit<CR>


" Syntastic ***
"
NeoBundle 'scrooloose/syntastic'

let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': ['javascript'], 
      \ 'passive_filetypes': ['html', 'css'] }

" eslintは npm install -g eslint で導入し、jsと同じディレクトリで eslint --init を行う
" TODO: ホームディレクトリに .eslintrc を置けばグローバル的にやってくれるようなので、dotfileで管理する
let g:syntastic_javascript_checkers = ['eslint']

" チェック後に常にLocationListを更新するようにする
let g:syntastic_always_populate_loc_list = 1

" 保存終了(wq)時にはチェックを行わない
let g:syntastic_check_on_wq = 0 


" vim-yaml ***
NeoBundle 'stephpy/vim-yaml'


" emmet(zen-coding) ***
"
NeoBundle 'mattn/emmet-vim'

" インデントは半角スペース4個
let g:user_emmet_settings = {
      \'lang' : 'ja',
      \'indentation' : '    '
      \}


" surround ***
"
NeoBundle 'tpope/vim-surround'


" neocomplete ***
"
NeoBundle 'Shougo/neocomplete.vim'

" 有効化
let g:neocomplete#enable_at_startup = 1
" 大文字が入力されるまで大文字/小文字の別を無視する
let g:neocomplete#enable_smart_case = 1

" エンターキーで候補リストを閉じるだけにする
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  " 改行も挿入する場合は以下
  " return neocomplete#close_popup() . "\<CR>"
endfunction

" タブキーで選択を行う(Tabで下にShift+Tabで上に)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" オムニ補完を行う
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" 補完リストの高さを固定
set pumheight=10


" choosewin ***
"
NeoBundle 't9md/vim-choosewin'

nmap - <Plug>(choosewin)


" open-browser ***
"
NeoBundle 'tyru/open-browser.vim'

nmap gs <Plug>(openbrowser-smart-search)
vmap gs <Plug>(openbrowser-smart-search)


" solarized(colorscheme) ***
"
NeoBundle 'altercation/vim-colors-solarized'


" lightline(status-line colorscheme) ***
"
NeoBundle 'itchyny/lightline.vim'


call neobundle#end()

filetype plugin indent on


" 起動時にインストールチェックを行う。***
"
NeoBundleCheck



"---------------------------------------------------------------------------
" 編集関連
"

" インデント 
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=0

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.html setlocal tabstop=4 shiftwidth=4 softtabstop=0
  autocmd BufNewFile,BufRead *.js setlocal tabstop=2 shiftwidth=2 softtabstop=0
  autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=0
  autocmd BufNewFile,BufRead *.css setlocal tabstop=2 shiftwidth=2 softtabstop=0
  autocmd BufNewFile,BufRead *.json setlocal tabstop=2 shiftwidth=2 softtabstop=0
  autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 shiftwidth=2 softtabstop=0
augroup END

" テキストのtextwidthのデフォルトを解除(=自動改行を行わないようにしている)
autocmd FileType text setlocal textwidth=0

" html,body,head,tbodyについて、インデントを行うようにする
let g:html_indent_inctags = "html,body,head,tbody"


"---------------------------------------------------------------------------
" 表示関連
"
set number
set laststatus=2
set cmdheight=1

set nowrap

set cursorline


"---------------------------------------------------------------------------
" ファイル関連
"
" デフォルトのファイルフォーマットをutf-8とする
set fenc=utf-8


"---------------------------------------------------------------------------
" ファイル復元関連
"
set nobackup
set noswapfile
set noundofile


"---------------------------------------------------------------------------
" 色関連(colorscheme)
"
colorscheme desert 


"---------------------------------------------------------------------------
" _vimrc,_gvimrcを編集しやすく
"
" キーマッピング(Spc+(ev,gv))
let $MYVIMRC = '$HOME/dotfiles/_vimrc'
let $MYGVIMRC = '$HOME/dotfiles/_gvimrc'
nnoremap <silent> <Space>ev :edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg :edit $MYGVIMRC<CR>

" ファイル(_vimrc,_gvimrc)保存時に自動で再読み込みを行う
augroup SourceVimrcCmd 
  autocmd!
augroup END

if !has('gui_running')
  autocmd SourceVimrcCmd BufWritePost _vimrc source $MYVIMRC
else
  autocmd SourceVimrcCmd BufWritePost _vimrc source $MYVIMRC | source $MYGVIMRC 
  autocmd SourceVimrcCmd BufWritePost _gvimrc source $MYGVIMRC
endif


"---------------------------------------------------------------------------
" Todoリストを管理(単なるメモ帳)
"
command! Todo edit ~/todo.txt
command! Memo edit ~/memo.txt

