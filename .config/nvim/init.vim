"================================Plugins=================================
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" better defaults
Plug 'sheerun/vim-polyglot'

Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-visual-star-search'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'tommcdo/vim-exchange'

" version control
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" UI
"Plug 'joshdick/onedark.vim'
"Plug 'liuchengxu/space-vim-dark'
"Plug 'lifepillar/vim-solarized8'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/seoul256.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" format and lint
Plug 'w0rp/ale'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'junegunn/vim-easy-align'

" auto-completion
Plug 'Valloric/YouCompleteMe'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" functions
Plug 'scrooloose/nerdtree'
Plug 'jpalardy/vim-slime'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'dyng/ctrlsf.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'terryma/vim-multiple-cursors'
Plug 'plytophogy/vim-virtualenv'

" Initialize plugin system
call plug#end()

"============================system settings=============================
let g:python3_host_prog = '/usr/local/bin/python3'

"============================better defaults=============================
set encoding=utf-8
set number 		"row number
set relativenumber
set nocompatible	"set compatible
set hlsearch
set incsearch		"enable incsearch
set hidden		"navigate away from a modified file without first saving
set nowrap              "disable auto line break
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set confirm
set foldmethod=indent
set foldlevel=1
set foldlevelstart=99
set laststatus=2

filetype plugin indent on
runtime macros/matchit.vim

syntax on

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
nnoremap <esc> :noh<CR><esc>

noremap H ^
noremap L $

nnoremap <leader>qq :q<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

vnoremap <leader><C-c> "*y
nnoremap <leader><C-v> "*p

nmap gx <Plug>(Exchange)
xmap X <Plug>(Exchange)
nmap gX <Plug>(ExchangeClear)
nmap gxx <Plug>(ExchangeLine)

"easymotion
map <leader>j <Plug>(easymotion-prefix)

" buffer operation
nnoremap <leader>bk :bd<CR>
nnoremap <leader>bb :Leaderf buffer<CR>

" window operation
nnoremap <leader>wd :close<CR>
nnoremap <leader>wm :only<CR>

" file operation
nnoremap <leader>ff :Leaderf file<CR>
nnoremap <leader>fr :Leaderf mru<CR>
noremap <leader>fT :NERDTreeToggle<CR>

" search operation
nnoremap <leader>sj :Leaderf bufTag --right<CR>
nnoremap <leader><C-f> :LeaderfFunction!<CR>
nnoremap <leader>sp :CtrlSF<Space>
noremap <C-S> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>

autocmd FileType python nnoremap <leader>= :0,$!yapf<CR>

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

"=============================plugin settings===========================
let NERDTreeShowHidden = 1
let g:ctrlsf_ackprg = 'rg'

" airline
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_powerline_fonts               = 1
"let g:airline#extensions#branch#enabled     = 1
"let g:airline#extensions#tabline#enabled    = 1
"let g:airline#extensions#ale#enabled        = 1
"let g:airline#extensions#virtualenv#enabled = 1
"let g:airline_theme                         = 'zenburn'

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
let g:ycm_python_binary_path='python'
set completeopt=menu,menuone

let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }

" Leaderf
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
let g:Lf_CommandMap = {'<C-K>': ['<C-P>'], '<C-J>': ['<C-N>']}
"============================add log files==============================
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_NCM_LOG_LEVEL="DEBUG"
let $NVIM_NCM_MULTI_THREAD=0

set background=light
let g:seoul256_background = 255
colorscheme seoul256
