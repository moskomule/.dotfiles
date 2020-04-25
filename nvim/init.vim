""" moskomule .vimrc
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

" costum keymapping
" save
nnoremap <Space>w :w<CR>
" quit
nnoremap <Space>q :q<CR>
" quit vim
nnoremap <C-x> :qa<CR>


" escape from searching mode
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" easier split navigation (omit C-w)
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>


if has('nvim') || v:version >= 800
    if &compatible
        set nocompatible
    endif

    
    augroup MyAutoCmd
      autocmd!
    augroup END
    
    " dein settings
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
    " ignore extensions
    let NERDTreeIgnore = ['.(tgz|gz|zip)$' ]
    
    " EasyAlign
    " start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)
    " start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

    " python
    let g:python3_host_prog = expand('$HOME/.dotfiles/venv/bin/python')

    " deoplete
    let g:deoplete#enable_at_startup = 1

    " denite
    nmap <silent> ,f :<C-u>Denite file/rec <CR>
    nmap <silent> ,r :<C-u>Denite file/old<CR>
    nmap <silent> ,g :<C-u>Denite grep<CR>
    nmap <silent> ,b :<C-u>Denite buffer<CR>
    autocmd FileType denite call s:denite_settings()
    function! s:denite_settings() abort
        " enter = open in denite
        nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action') 
        nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview') 
        nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit') 
        nnoremap <silent><buffer><expr> q denite#do_map('quit') 
        nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
    endfunction

    autocmd FileType denite-filter call s:denite_filter_settings()
    function! s:denite_filter_settings() abort
        nnoremap <silent><buffer><expr> q denite#do_map('quit')
        imap <silent><buffer> <ESC> <Plug>(denite_filter_quit)
    endfunction

    call denite#custom#kind('file', 'default_action', 'vsplit')

    " floating window
    let s:denite_win_width_percent = 0.85
    let s:denite_win_height_percent = 0.7
    
    " Change denite default options
    call denite#custom#option('default', {
        \ 'split': 'floating',
        \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
        \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
        \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
        \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
        \ 'prompt': '>> ',
        \ })

    " jedi-vim
    autocmd FileType python setlocal completeopt-=preview
    "let g:deoplete#sources#jedi#show_docstring = 1

    " use <CR> to select candidates
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " vim-airline
    " theme settings
    let g:airline_theme="onedark"
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
    nnoremap <C-m> :ALEFix<CR>

    " set color of number, comments
    autocmd ColorScheme * highlight LineNr ctermfg=240
    autocmd ColorScheme * highlight Comment ctermfg=242
    colorscheme onedark

endif
    
" use clipboard
if has('mac')
    set clipboard&
    set clipboard^=unnamedplus
endif
