"================================Plugins=================================
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Improved syntax highlighting
Plug 'nelstrom/vim-visual-star-search'
Plug 'w0rp/ale'
Plug 'roxma/nvim-completion-manager'
Plug 'scrooloose/nerdtree'
Plug 'fisadev/vim-isort'
Plug 'jpalardy/vim-slime'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
call plug#end()

"===================================settings=============================
set encoding=utf-8
set number 		"row number
set nocompatible	"set compatible
set incsearch		"enable incsearch
set hidden		"navigate away from a modified file without first saving
set nowrap              "disable auto line break
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
    let g:python3_host_prog = '/home/claude/anaconda3/bin/python'
endif

filetype plugin indent on
runtime macros/matchit.vim

syntax on
colorscheme onedark

"============================enable true color===========================
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

"================================key map=================================
let mapleader="\<space>"
noremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

map <leader><C-n> :NERDTreeToggle<CR>

map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>

nnoremap <C-f> :CtrlSF<Space>

autocmd FileType python nnoremap <leader>= :0,$!yapf<CR>
autocmd FileType python nnoremap <leader>i :!isort %<CR><CR>

"=============================plugin settings===========================
let NERDTreeShowHidden = 1
let g:ctrlsf_ackprg = 'ag'

" airline
let g:airline_powerline_fonts = 1

" airline with extensions
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" ale
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'python': ['flake8'],
\}

" slime
let g:slime_target = "tmux"
let g:slime_python_ipython = 1

if !empty($TMUX)
    let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
endif

"============================add log files==============================
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_NCM_LOG_LEVEL="DEBUG"
let $NVIM_NCM_MULTI_THREAD=0
