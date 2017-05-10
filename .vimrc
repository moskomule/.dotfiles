" own settings
set number
set ruler
set encoding=UTF-8
set fileencoding=UTF-8
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set hlsearch
set cursorline
set incsearch
set ignorecase 	
set smartcase
set wrapscan
"set clipboard+=unnamedplus
set clipboard&
set clipboard^=unnamedplus

nnoremap s <Nop>
nnoremap sh :split<CR> <C-w><C-j>
nnoremap sv :vsplit<CR>

nnoremap  <silent> <C-t> :split<CR> <C-w><C-j> :terminal<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>

"neovim terminal settings
tnoremap <ESC> <C-\><C-n>
tnoremap <silent> <C-t> <C-\><C-n> :q <CR>

" dein settings {{{
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
let s:toml      = '~/.config/dein/plugins.toml'
" let s:lazy_toml = '~/.config/dein/plugins_lazy.toml'

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [s:toml])
    call dein#load_toml(s:toml, {'lazy': 0})
    " call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif
" }}}

if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

let g:deoplete#enable_at_startup = 1

"denite settings
nmap <silent> <C-u><C-f> :<C-u>Denite filetype<CR>
nmap <silent> <C-u><C-p> :<C-u>Denite file_rec<CR>
nmap <silent> <C-u><C-l> :<C-u>Denite line<CR>
nmap <silent> <C-u><C-g> :<C-u>Denite grep<CR>
nmap <silent> <C-u><C-u> :<C-u>Denite file_mru<CR>
nmap <silent> <C-u><C-y> :<C-u>Denite neoyank<CR>

"activate NERDTree
map <C-n> :NERDTreeToggle<CR>

" Easier split navigation

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" launch ndtree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd VimEnter if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"ignore
let NERDTreeIgnore = ['.(tgz|gz|zip)$' ]

"EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
