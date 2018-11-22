"================================Plugins=================================
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

Plug 'sheerun/vim-polyglot'

"Plug 'joshdick/onedark.vim'
"Plug 'liuchengxu/space-vim-dark'
"Plug 'lifepillar/vim-solarized8'
Plug 'NLKNguyen/papercolor-theme'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Improved syntax highlighting
Plug 'wellle/targets.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'w0rp/ale'
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
Plug 'Valloric/YouCompleteMe'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/YankRing.vim'
Plug 'scrooloose/nerdcommenter'

" Initialize plugin system
call plug#end()

"===================================settings=============================
set encoding=utf-8
set number 		"row number
set relativenumber
set nocompatible	"set compatible
set hlsearch
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

set background=light
colorscheme PaperColor
hi Comment cterm=italic

"============================enable true color===========================
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

"================================key map=================================
tnoremap <Esc> <C-\><C-n>

let mapleader="\<space>"
noremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

noremap H ^
noremap L $

nnoremap <leader>x :bd<CR>
nnoremap QQ :q!<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

vnoremap <leader><C-c> "*y
nnoremap <leader><C-v> "*p

map <C-b> :NERDTreeToggle<CR>

map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>

nnoremap <leader>sf :CtrlSF<Space>

autocmd FileType python nnoremap <leader>= :0,$!yapf<CR>
autocmd FileType python nnoremap <leader>i :!isort %<CR><CR>

nnoremap gd :YcmCompleter GoTo<CR>
nnoremap <space>gj :YcmCompleter GetDoc<CR>

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-n>'
let g:UltiSnipsJumpBackwardTrigger = '<C-p>'

let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> <leader>y :YRShow<CR>
let g:yankring_replace_n_pkey = '<Leader>m'
let g:yankring_replace_n_nkey = '<Leader>n'
"=============================plugin settings===========================
let NERDTreeShowHidden = 1
let g:ctrlsf_ackprg = 'ag'

" airline
let g:airline_powerline_fonts            = 1
let g:airline#extensions#branch#enabled  = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled     = 1
let g:airline_theme                      = 'papercolor'

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

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_python_binary_path = 'python3'
set completeopt=menu,menuone

let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }

" Leaderf
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
nnoremap <leader><C-t> :Leaderf bufTag --right<CR>
nnoremap <leader><C-f> :LeaderfFunction!<CR>
"============================add log files==============================
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_NCM_LOG_LEVEL="DEBUG"
let $NVIM_NCM_MULTI_THREAD=0
