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

set splitbelow
set splitright

" enable use mouse in every mode
set mouse=a

" costum keymappings
" save
nnoremap <Space>w :w<CR>
" quit
nnoremap <Space>q :q<CR>
" quit vim
nnoremap <Space>x :qa<CR>

" escape from searching mode
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" buffers
nnoremap <silent> [b :bprev<CR>
nnoremap <silent> ]b :bnext<CR>

" windows


if has('nvim') || v:version >= 800
    if &compatible
        set nocompatible
    endif

    
    augroup MyAutoCmd
      autocmd!
    augroup END
    
    " python
    let g:python3_host_prog = expand('$HOME/.dotfiles/venv/bin/python')

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
    let g:dein#auto_recache = 0
    
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

    
    nnoremap <silent><C-n> :Defx -split=vertical -winwidth=50 -direction=topleft<CR>
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Defx | endif
    " automatically redraw
    autocmd BufWritePost * call defx#redraw()

    autocmd FileType defx call s:defx_settings()
    function! s:defx_settings() abort

        nnoremap <silent><buffer><expr><CR> defx#is_directory() ? defx#do_action('open_or_close_tree'):  defx#do_action('multi', ['drop', 'quit'])
        nnoremap <silent><buffer><expr>v defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
        nnoremap <silent><buffer><expr>s defx#do_action('multi', [['drop', 'split'], 'quit'])
        nnoremap <silent><buffer><expr>. defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr>p defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr><C-n> defx#do_action('quit')
        nnoremap <silent><buffer><expr>o defx#is_opened_tree() ? defx#do_action('close_tree'): defx#do_action('open_tree_recursive')
        nnoremap <silent><buffer><expr>yy defx#do_action('yank_path')
        nnoremap <silent><buffer><expr>S defx#do_action('toggle_sort', 'time')
    endfunction
    
    call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'toggle': 1,
      \ })


    " deoplete
    let g:deoplete#enable_at_startup = 1

    " denite
    nmap <silent> ,f :<C-u>Denite file/rec <CR>
    nmap <silent> ,r :<C-u>Denite file/old<CR>
    nmap <silent> ,g :<C-u>Denite grep<CR>
    nmap <silent> ,b :<C-u>Denite buffer<CR>
    nmap <silent> ,m :<C-u>Denite menu<CR>
    nmap <silent> ,y :<C-u>Denite neoyank<CR>

    " when denite is active
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

    " when denite-filter is active
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

    "menu
    let s:menus = {}
    let s:menus.dotfiles = {'description': 'Edit .dotfiles'}
    let s:menus.dotfiles.file_candidates = [
        \ ['zsh_shared', '~/.dotfiles/zsh/shared'],
        \ ['.zshrc', '~/.zshrc'],
        \ ['.vimrc', '~/.vimrc'],
        \ ['.tmux.conf', '~/.tmux.conf'],
        \ ['plugins.toml', '~/.dotfiles/dein/plugins.toml'],
        \ ['plugins_lazy.toml', '~/.dotfiles/dein/plugins_lazy.toml'],
        \]

    call denite#custom#var('menu', 'menus', s:menus)

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
