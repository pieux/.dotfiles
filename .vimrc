" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=80 foldmarker={,} foldlevel=0 foldmethod=marker:
" }

" 1 important {
    set nocompatible

    " NeoBundle Configuration {
        if has('vim_starting')
            set runtimepath+=~/.vim/bundle/neobundle.vim/
        endif
        call neobundle#rc(expand('~/.vim/bundle/'))
        " Let NeoBundle manage NeoBundle
        NeoBundleFetch 'Shougo/neobundle.vim'
        " Recommended to install
        " After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
        NeoBundle 'Shougo/vimproc'
        if filereadable(expand("~/.vimrc.bundles"))
            source ~/.vimrc.bundles
        endif
        filetype plugin indent on   " Required!
        " Brief help
        " :NeoBundleList          - list configured bundles
        " :NeoBundleInstall(!)    - install(update) bundles
        " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

        " Installation check.
        NeoBundleCheck
    " }
" }

" 2 moving around, searching and patterns {
    set whichwrap=b,s,<,>,[,]   " :h whichwrap
    set showmatch
    set incsearch
    set ignorecase 

    " restoe cursor location {
        function! RestoreCursor()
            if line("'\"") > 1 && line("'\"") <= line("$")
                exe "normal! g`\""
                return 1
            endif
        endfunction
    " }
    au BufReadPost * call RestoreCursor()
" }

    " 3 tag {

    " }

" 4 displaying text {
    set scrolljump=5
    set scrolloff=3
    set nowrap
    set linespace=0

    " set list
    " set listchars=tab:,.,trail:.,extends:#,nbsp:.   " highlight problematic whitespace

    set number
    set relativenumber
    set numberwidth=4

    augroup BgHighlight
        autocmd!
            highlight OverLength ctermbg=darkgrey ctermfg=darkred guibg=#0D4352
            autocmd WinEnter * set colorcolumn=80
            autocmd WinLeave * set colorcolumn=0
    augroup END
" }

" 5 syntax, highlighting and spelling {
    set t_Co=256
    set background=light
    if has('gui_running')
        set background=light
    endif
    color molokai
    syntax on
    set hlsearch
    set cursorline
    set nospell
" }

" 6 multiple windows {
    set hidden
" }

" 7 multiple tab pages {

" }

" 8 terminal {

" }

" 9 using the mouse {
    set mouse=a
    set mousehide
" }

" 10 GUI {
    set guifont=Monaco\ for\ Powerline:h15
    set guioptions=aegimrLtT
"}

" 11 printing {

" }

" 12 message and info {
    set showcmd
    set showmode
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set shortmess+=filmnrxoOtT  " Abbrev. of messages (avoids 'hit enter')
    if has('statusline')
        set laststatus=2
        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set noerrorbells visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=
"}

" 13 selecting text {
    " clipboard {
        if has ('x') && has ('gui')
            set clipboard=unnamedplus
        elseif has ('gui')
            set clipboard=unnamed
        endif
    " }
"}

" 14 editing text {
    set backspace=indent,eol,start
    set matchpairs=(:),{:},[:]
"}

" 15 tabs and indenting {
    set autoindent
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set softtabstop=2   
    " strip whitespace {
        function! StripTrailingWhitespace()
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
    " }
    autocmd FileType c,cpp,java,javascript,python,ruby,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
"}

" 16 folding {
    set foldenable
    set foldlevel=0
" }

" 17 diff mode {

"}

" 18 mapping {
    nnoremap ; :
    nnoremap j gj
    nnoremap k gk
    nnoremap Y y$

    vnoremap < <gv
    vnoremap > >gv

    let mapleader=','
    nmap <silent> <leader>/ :set invhlsearch<CR>

    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    map zl zL
    map zh zH

    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    cmap w!! w !sudo tee % >/dev/null

    " stupid shift key fixes {
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif
    " }

    cmap Tabe tabe
"}

" 19 reading and writing files {

    " initialize directories {
        function! InitializeDirectories()
            let parent = $HOME
            let prefix = 'vim'
            let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

            if has('persistent_undo')
                let dir_list['undo'] = 'undodir'
            endif

            " To specify a different directory in which to place the vimbackup,
            " vimviews, vimundo, and vimswap files/directories, add the following to
            " your .vimrc.local file:
            "   let g:spf13_consolidated_directory = <full path to desired directory>
            "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
            if exists('g:spf13_consolidated_directory')
                let common_dir = g:spf13_consolidated_directory . prefix
            else
                let common_dir = parent . '/.' . prefix
            endif

            for [dirname, settingname] in items(dir_list)
                let directory = common_dir . dirname . '/'
                if exists("*mkdir")
                    if !isdirectory(directory)
                        call mkdir(directory)
                    endif
                endif
                if !isdirectory(directory)
                    echo "Warning: Unable to create backup directory: " . directory
                    echo "Try: mkdir -p " . directory
                else
                    let directory = substitute(directory, " ", "\\\\ ", "g")
                    exec "set " . settingname . "=" . directory
                endif
            endfor
        endfunction
    " }

    call InitializeDirectories()
    set backup                      " backups are nice ...
    if has('persistent_undo')
        set undofile                " so is persistent undo ...
        set undolevels=1000         " maximum number of changes that can be undone
        set undoreload=10000        " maximum number lines to save for undo on a buffer reload
    endif

" }

" 20 the swap file {

" }

" 21 command line editing {
    set wildmenu
    set wildmode=list:longest,full
    set history=500
" }

" 22 executing external commands {
" }

" 23 running make and jumping to errors {
" }

" 24 language specific {
    augroup filetypedetect
        au BufRead,BufNewFile *.rabl setf rabl.ruby
        au BufRead,BufNewFile *.html setf handlebars.html
        au BufRead,BufNewFile *_spec.rb setf rspec.ruby
    augroup END

    au FileType python,snippets,xml setl sw=4 sts=4 et
    au FileType ruby setl sw=2 sts=2 et
" }

" 25 multi-byte characters {
    scriptencoding utf-8
" }

" 26 various {
    set virtualedit=onemore 
    set viewoptions=folds,options,cursor,unix,slash " better Unix / Windows compatibility
" }