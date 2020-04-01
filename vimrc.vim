set encoding=utf-8
set langmenu=zh_CN.UTF-8

set nowrap ""禁止自动折行


set nocompatible              " be iMproved, required
filetype off                  " required

"=================================================== vim-plug  ==============================================
"vim-plug, see: https://github.com/junegunn/vim-plug
" first setup curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
"Plug 'tacahiroy/ctrlp-funky'
Plug 'ctrlpvim/ctrlp.vim'
" Use <leader>t to open ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" " Ignore these directories
set wildignore+=*/build/**
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|idea|build)|target|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|class)$',
  \ 'link': 'some_bad_symbolic_links',
  \
  \}
"disable caching
let g:ctrlp_use_caching=0

"Plug 'Valloric/MatchTagAlways' "html tag highlight

Plug 'nathanaelkane/vim-indent-guides'
":help indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
"let g:indent_guides_enable_on_vim_startup = 1

"Clojure REPL support
"Plug 'tpope/vim-fireplace'
"

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1    "set to 0 if you want to enable it later via :RainbowToggle

Plug 'guns/vim-sexp'

Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap ss <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
"End easy motion config ===================

Plug 'airblade/vim-gitgutter'

Plug 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'modified', 'relativepath' ] ]
      \ }}
Plug 'bling/vim-bufferline'
let g:bufferline_rotate = 1  "scrolling with fixed current buffer position
"let g:bufferline_echo = 0
"let g:lightline = {
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'readonly', 'modified', 'buffers' ] ]
"      \ },
"      \ 'component_function': {
"      \   'buffers': 'bufferline#get_echo_string'
"      \ },
"      \ }

Plug 'neoclide/coc.nvim',{'branch': 'release'}
source ~/.coc.vimrc

Plug 'mileszs/ack.vim'

call plug#end()
"PlugInstall [name ...] [#threads]	Install plugins
"PlugUpdate [name ...] [#threads]	Install or update plugins
"PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
"PlugUpgrade	Upgrade vim-plug itself
"PlugStatus	Check the status of plugins
"PlugDiff	Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins
"================================================== end vim-plug ================================================



filetype plugin indent on    " required
set nocompatible " 关闭 vi 兼容模式
syntax on " 自动语法高亮
set number " 显示行号
set relativenumber "显示相对行号
set cursorline " 突出显示当前行
set ruler " 打开状态栏标尺
set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏
set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
"autocmd! bufwritepost ~/_vimrc source % "配置文件修改，自动更新
set nobackup " 覆盖文件时不备份
set noswapfile "不产生swp文件
set smartindent " 开启新行时使用智能自动缩进

set nocursorline "禁止下划线

set updatetime=2000


set showcmd

set tabstop=4
set list
set listchars=tab:>.
highlight lineNr guibg=grey guifg=white
highlight specialkey guifg=lightgray

"设置json缩进
autocmd FileType json,js set shiftwidth=4 | set expandtab
"html
autocmd FileType html set shiftwidth=4 | set expandtab

let g:netrw_winsize=-35
let g:netrw_liststyle=3 "default use tree style
let g:netrw_list_hide= netrw_gitignore#Hide()
map <silent><F5> :Lexplore<cr>"
