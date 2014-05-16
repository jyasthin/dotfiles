"---------------------------------------------------------------------------
" NeoBundle(プラグイン)
"
set nocompatible

if has("vim_starting")
  set runtimepath+=~/dotfiles/vimfiles/bundle/neobundle.vim/ 
endif
call neobundle#rc(expand("~/dotfiles/vimfiles/bundle/"))


" NeoBundle ***
" submoduleを使っているのでNeoBundleの管理下から外す 
" submoduleを使わない(初期にcloneで入れる)のであれば、管理下に入れる
" 
"NeoBundleFetch 'Shougo/neobundle.vim'


" シンタックスチェック ***
"
NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': [], 
      \ 'passive_filetypes': ['html', 'css'] }
let g:syntastic_auto_loc_list = 1 
let g:syntastic_javascript_checker = 'gjslint'


" zencoding ***
"
NeoBundle 'mattn/emmet-vim'
" インデントは半角スペース4個
let g:user_zen_settings = {
      \'lang' : 'ja',
      \'indentation' : '    '
      \}


" solarized(colorscheme) ***
"
NeoBundle 'altercation/vim-colors-solarized'


filetype plugin indent on


" 起動時にインストールチェックを行う。***
"
NeoBundleCheck



"---------------------------------------------------------------------------
" 編集関連
"
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=0

" テキストのtextwidthのデフォルトを解除
autocmd FileType text setlocal textwidth=0

" htmlについて、インデントを行うようにする
:let g:html_indent_inctags = "html,body,head,tbody"


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


"---------------------------------------------------------------------------
" 色関連(colorscheme)
"
colorscheme desert 



"---------------------------------------------------------------------------
"挿入モード時、ステータスラインの色を変更
"
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=white ctermbg=darkyellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


"---------------------------------------------------------------------------
" _vimrc,_gvimrcを編集しやすく
"
" キーマッピング(Spc+(ev,gv))
let $MYVIMRC = '$HOME\dotfiles\_vimrc'
let $MYGVIMRC = '$HOME\dotfiles\_gvimrc'
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

