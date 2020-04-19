""" moskomule .vimrc
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
" interactive replacing
set inccommand=split
" show status lines everytime
set laststatus=2

" enable use mouse in every mode
set mouse=a

" save
nnoremap <Space>w :w<CR>
" quit
nnoremap <Space>q :q<CR>

" quit vim
nnoremap <C-x> :qa<CR>
"nnoremap s <Nop>
" split horizontally and move below
"nnoremap sh :split<CR> <C-w><C-j>
" split vertically
nnoremap s <Nop>
nnoremap sv :vsplit 
nnoremap sh :split 
" tab
nnoremap t <Nop>
nnoremap te :tabedit  
nnoremap tt :tabnew 
nnoremap tn gt
" buffer
nnoremap B :b 

" escape from searching mode
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" easier split navigation (omit C-w)
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
" maximize window
nnoremap <C-w>z <C-w>_<C-w>|

nmap <silent> <C-u><C-v> :vsplit $XDG_CONFIG_HOME/nvim/init.vim<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    " neovim terminal settings
    " launch a terminal below 
    nnoremap  <C-t> :split<CR> <C-w><C-j> :terminal<CR>
    " change to the terminal-command mode
    tnoremap <Esc> <C-\><C-n>
    " quit the terminal
    tnoremap <silent> <C-w> <C-\><C-n> :q! <CR>
    " move to the window above from terminal
    tnoremap <silent> <C-k> <C-\><C-n> <C-w><C-k>
endif
    

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein settings

if has('nvim') || v:version >= 800
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
    let s:lazy_toml = '$XDG_CONFIG_HOME/dein/plugins_lazy.toml'
    
    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir, [s:toml])
        call dein#load_toml(s:toml, {'lazy': 0})
        call dein#load_toml(s:lazy_toml, {'lazy': 1})
        call dein#end()
        call dein#save_state()
    endif
    
    if has('vim_starting') && dein#check_install()
        call dein#install()
    endif
    
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1

    " activate NERDTree
    map <C-n> :NERDTreeToggle<CR>
    
    
    " launch ndtree automatically
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    let NERDTreeIgnore = ['.(tgz|gz|zip)$' ]
    
    " EasyAlign
    " start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)


    " deoplete
    " use <CR> to select candidates
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    let g:deoplete#enable_at_startup = 1

    " jedi-vim
    autocmd FileType python setlocal completeopt-=preview
    "let g:deoplete#sources#jedi#show_docstring = 1

    " vim-airline
    " theme settings
    let g:airline_theme="light"
    " others
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#hunks#enabled = 1 
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#ale#error_symbol = 'E:'
    let g:airline#extensions#ale#warning_symbol = 'W:'
    
    "ale
    let g:ale_linters = {
    \ 'python': ['autopep8', 'pyre'],
    \ 'cpp': ['clangd'],
    \}
    let g:ale_fixers = {
    \ 'python': ['autopep8'],
    \}
    "let g:ale_sign_column_always = 1
    "let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    nnoremap <C-m> :ALEFix<CR>
endif
    
" use clipboard
if has('mac')
    set clipboard&
    set clipboard^=unnamedplus
endif
