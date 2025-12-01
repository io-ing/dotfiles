set tabstop=4           " 设置 tab 宽度为 4 个空格
set shiftwidth=4        " 设置自动缩进宽度为 4 个空格
set expandtab           " 将 tab 替换为空格
set nu                  " 显示行号
set shortmess=atI       " 隐藏启动时帮助信息
set ic                  " 搜索时忽略大小写
set hls                 " 高亮搜索结果
set is                  " 启用增量搜索
set tags=./tags;,/      " 在当前目录及向上查找 tags 文件
set tabpagemax=150      " 标签页最大数量
set completeopt=menu,menuone,noselect " 补全菜单选项
set backspace=indent,eol,start        " 允许多种情况下退格
set timeoutlen=300      " 映射超时时间
set ttimeoutlen=10      " 终端键超时时间
filetype plugin indent off " 关闭自动缩进

let mapleader = " "     " 设置 leader 键为空格

" quickfix 快捷键
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>

"set smartindent         " 设置智能缩进，这个选项会导致粘贴代码自动缩进
"set relativenumber      " 启用行号相对显示
"set cursorline          " 启用行高亮
" 保存文件的时候自动生成 ctags
"autocmd BufWritePost *.[ch] call system('ctags -R .')

call plug#begin('~/.vim/plugged')

" Git 集成插件
Plug 'tpope/vim-fugitive'

" 目录树插件
Plug 'preservim/nerdtree'

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '~80%' }
" Optional: Configure fzf.vim key mappings
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-m> :Marks<CR>
"nnoremap <silent> <C-b> :Buffers<CR>
"nnoremap <silent> <C-t> :History<CR>
"nnoremap <silent> <C-f> :Rg<CR> " Requires ripgrep

Plug 'preservim/tagbar'

call plug#end()

filetype plugin indent off " 关闭自动缩进
