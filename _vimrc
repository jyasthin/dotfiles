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
" インデント関連
"
autocmd FileType javascript setl shiftwidth=4 softtabstop=4 expandtab
autocmd FileType html setl shiftwidth=4 softtabstop=4 expandtab


"---------------------------------------------------------------------------
" 編集関連
"
set tabstop=4


"---------------------------------------------------------------------------
" 表示関連
"
set number
set laststatus=2
set cmdheight=1

set nowrap

set cursorline


"---------------------------------------------------------------------------
" バックアップ関連
"
set nobackup


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
