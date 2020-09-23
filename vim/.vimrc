" Setup plug in manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
" Plug 'ycm-core/YouCompleteMe'
" Plug 'davidhalter/jedi-vim'
Plug 'sheerun/vim-polyglot'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'garybernhardt/pycomplexity'
call plug#end()

"
" Setup variables
"

" syntax on
" colorscheme sublimemonokai
let mapleader = ","
set number
set ts=4
set softtabstop=4
set autoindent
set expandtab
set shiftwidth=4
set cursorline
set showmatch
set textwidth=79
set encoding=utf-8
set hlsearch
set ignorecase
set smartcase
set wildmenu
set fileformat=unix
set laststatus=2
let g:python_highlight_space_errors = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

"
" Vim Remapping
"
nnoremap <leader>g <C-]>

"
" NerdTree
"
nnoremap <Leader>o :NERDTreeToggle<Enter>

"
" TAGBAR
"
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
nmap <F6> :TagbarToggle<CR>

"
" ALE
"
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"
let g:ale_linters = {"python": ["pylama", "mypy"]}

"
" Jedi config
"
" let g:jedi#goto_command = "<leader>d"
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_definitions_command = ""
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>r"

"
" YouCompleteMe
"
" let g:YcmCompleter#GoToDeclaration = "<leader>d"
" let g:YcmCompleter#GoTo = "<leader>g"
" let g:YcmCompleter#GoToReferences = "<leader>r"
" let g:YcmCompleter#GetDoc = "<leader>?"


"
" File specific settings
"
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2

au! BufNewFile,BufReadPost *.{html} set filetype=html foldmethod=indent
autocmd FileType html setlocal ts=2 sts=2 sw=2

au! BufNewFile,BufReadPost *.{js} set filetype=javascript foldmethod=indent
autocmd FileType javascript setlocal ts=2 sts=2 sw=2

" Trailing white space removed on save
autocmd BufWritePre * %s/\s\+$//e
