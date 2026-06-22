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

" 安装 coc.nvim（LSP 客户端）
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

filetype plugin indent off " 关闭自动缩进

" ================== coc.nvim 基本设置 ==================
" gd 跳到定义
nmap <silent> gd <Plug>(coc-definition)
"" gy 跳到类型定义
"nmap <silent> gy <Plug>(coc-type-definition)
"" gi 跳到实现
"nmap <silent> gi <Plug>(coc-implementation)
" gr 查找引用
nmap <silent> gr <Plug>(coc-references)

" K 查看文档
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

"" <leader>rn 重命名
"nmap <leader>rn <Plug>(coc-rename)
"
"" 格式化当前文件
"nmap <leader>f <Plug>(coc-format)
"
"" 代码诊断（错误、警告）
"nmap <leader>a <Plug>(coc-codeaction)
"nmap <leader>qf <Plug>(coc-fix-current)
"
"" Tab 补全
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ coc#expandable() ? "\<C-r>=coc#expand()<CR>" :
"      \ "\<TAB>"
"
"" Shift-Tab 向上选择补全
"inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
"
"" 如果光标在错误处，<leader>e 会显示错误
"nnoremap <leader>e :CocDiagnostics<CR>
"
" 让 coc.nvim 支持标签跳转
set updatetime=300         " 提高响应速度
set shortmess+=c           " 不显示不必要的提示信息

"" 禁用 coc.nvim 自动弹出补全
"autocmd FileType python :call coc#config('suggest.autoTrigger', 'none')
"
"
"" Ctrl-P: 如果菜单可见 → 上一个候选，否则触发补全
"inoremap <silent><expr> <C-P> pumvisible() ? "\<C-p>" : coc#refresh()
"" Ctrl-N: 如果菜单可见 → 下一个候选，否则触发补全
"inoremap <silent><expr> <C-N> pumvisible() ? "\<C-n>" : coc#refresh()

" 完全关闭 sign column
set signcolumn=no
" 关闭 coc 虚拟文本
let g:coc_enable_virtual_text = 0

"" 补全菜单背景和文字
"highlight Pmenu      guibg=#1e1e1e guifg=#d4d4d4
"highlight PmenuSel   guibg=#264f78 guifg=#ffffff
"highlight PmenuSbar  guibg=#333333
"highlight PmenuThumb guibg=#666666
"
"" 内联提示颜色（CocInlayHint）
"highlight CocInlayHint guibg=#1e1e1e guifg=#9aa0a6

"" 颜色方案加载
"colorscheme default
"
"" 内联提示：透明背景 + 灰色文字
""highlight CocInlayHint guibg=NONE guifg=#9aa0a6
"highlight CocInlayHint guibg=#313459 guifg=#9aa0a6
"
"" 补全菜单（传统和 Coc 浮动）
"highlight Pmenu      guibg=#1e1e1e guifg=#d4d4d4
"highlight PmenuSel   guibg=#264f78 guifg=#ffffff
"highlight CocFloating guibg=#1e1e1e guifg=#d4d4d4
"highlight CocMenuSel guibg=#264f78 guifg=#ffffff

set encoding=utf-8

set termencoding=utf-8

set fileencodings=utf-8

set ambiwidth=double


