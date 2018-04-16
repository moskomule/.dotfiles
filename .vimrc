let OSTYPE = system('uname')
" own settings
set number
set ruler
set encoding=UTF-8
set fileencoding=UTF-8
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
" use relative number
set relativenumber
" highlight serched words
set hlsearch
set cursorline
" enable incremental searching
set incsearch
" ignore cases when lowercases
set ignorecase
" do not ignore cases when searching in uppercases
set smartcase
" go to the top if searching goes to the bottom
set wrapscan
" show status lines everytime
set laststatus=2

" enable use mouse in every mode
set mouse=a
" use clipboard

if OSTYPE == "Darwin\n"
    set clipboard&
    set clipboard^=unnamedplus
endif

" quit vim
nnoremap <C-x> :qa<CR>
nnoremap s <Nop>
" split horizontally and move below
nnoremap sh :split<CR> <C-w><C-j>
" split vertically
nnoremap sv :vsplit<CR>

" escape from searching mode
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein settings
if &compatible
    set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
execute 'set runtimepath^=' . s:dein_repo_dir

let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1
let s:toml = '$XDG_CONFIG_HOME/dein/plugins.toml'

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [s:toml])
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif

let g:deoplete#enable_at_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" plugins' settings

" activate NERDTree
map <C-n> :NERDTreeToggle<CR>

" easier split navigation (omit C-w)
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" launch ndtree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" ignore
let NERDTreeIgnore = ['.(tgz|gz|zip)$' ]

" EasyAlign
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

