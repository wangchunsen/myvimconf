set encoding=utf-8
set langmenu=zh_CN.UTF-8

set number
highlight lineNr guibg=grey guifg=white

set nocompatible " �ر� vi ����ģʽ
syntax on " �Զ��﷨����
set cursorline " ͻ����ʾ��ǰ��
set tabstop=4
set expandtab
set nowrap "��ֹ�Զ�����

"��ʾ�����ַ�
"set list
"set listchars=tab:>.
"highlight specialkey guifg=lightgray

"=======just copy the below part to your vimrc file 
"let s:vimrc_file = findfile('vimrc.vim', &runtimepath)
"if s:vimrc_file == ''
"   echo "Can not find vimrc.vim file in runtimepath:"
"   for path in split(&runtimepath, ',')
"        echo ">>" path
"   endfor
"else
"    exec 'source ' s:vimrc_file
"endif
"unlet! s:vimrc_file
"=======end


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
