"================================Plugins=================================
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Search selected text in visual mode
Plug 'nelstrom/vim-visual-star-search'

" Surroundings
Plug 'tpope/vim-surround'

" Enhanced substitution
Plug 'tpope/vim-abolish'

" Commenting and uncommenting
Plug 'tpope/vim-commentary'

"Complementary pairs of mappings
Plug 'tpope/vim-unimpaired'

"Git wrapper
Plug 'tpope/vim-fugitive'

"One-Dark theme
Plug 'joshdick/onedark.vim'

"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Improved syntax highlighting
Plug 'sheerun/vim-polyglot'

"Ale Linter
Plug 'w0rp/ale'

"Autocomplete
Plug 'roxma/nvim-completion-manager'

"Tree view
Plug 'scrooloose/nerdtree'

"Sort import commands
Plug 'fisadev/vim-isort'

"REPL
Plug 'jpalardy/vim-slime'

"yapf
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

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
let maplocalleader="\<space>"

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
noremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

map <C-n> :NERDTreeToggle<CR>

map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>

autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

"============================airline settings===========================
let g:airline_powerline_fonts = 1

" airline with extensions
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

"==============================ale settings=============================
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'python': ['flake8'],
\}
"=============================slime settings============================
let g:slime_target = "tmux"
let g:slime_python_ipython = 1

if !empty($TMUX)
    let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.1"}
endif

"============================add log files==============================
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_NCM_LOG_LEVEL="DEBUG"
let $NVIM_NCM_MULTI_THREAD=0
