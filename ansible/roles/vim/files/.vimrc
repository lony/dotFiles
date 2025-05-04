" Plugins

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
call plug#end()
let g:airline#extensions#tabline#enabled = 1

" Settings

if has("clipboard")                                         " enable clipboard if available else use plain
  set mouse=a
else
  set mouse=r
end

if has("mouse_sgr")                                         " enable scrolling in iTerm
	set ttymouse=sgr
else
	set ttymouse=xterm2
end

autocmd BufNewFile,BufRead Berksfile set filetype=ruby      " open Berksfile as ruby file
autocmd BufNewFile,BufRead Gemfile set filetype=ruby        " open Gemfile as ruby file
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby    " open Vagrantfile as ruby file
autocmd filetype crontab setlocal nobackup nowritebackup    " disables backups for writing crontab as in-place editing necessary
let g:netrw_altv=1                                          " open splits to the right
let g:netrw_banner=0                                        " disable banner
let g:netrw_browse_split=4                                  " open in prior window
let g:netrw_liststyle=3                                     " tree view
let mapleader=","                                           " change leader key
set autoindent                                              " always set autoindenting on
set backspace=indent,eol,start                              " allow backspacing over everything in insert mode
set clipboard^=unnamed,unnamedplus                          " enable clipboard copy and paste
set copyindent                                              " copy the previous indentation on autoindenting
set cursorline                                              " highlight current line
set encoding=utf-8
set foldenable                                              " enable folding
set foldlevelstart=10                                       " open most folds by default
set foldnestmax=10                                          " 10 nested fold max
set hidden                                                  " keep unsaved buffer hidden in the background
set history=1000                                            " remember more commands and search history
set hlsearch                                                " highlight search terms
set ignorecase                                              " ignore case when searching
set incsearch                                               " show search matches as you type
set laststatus=2                                            " always show status line
set nobackup                                                " create no backups
set nocompatible                                            " You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
set noerrorbells                                            " don't beep
set noswapfile                                              " disable creating .swp files
set novisualbell                                            " turn off visual bell
set nowrap                                                  " don't wrap lines
set number                                                  " always show line numbers
set pastetoggle=<F3>                                        " set F3 key to toggle :set paste vs nopaste
set path+=**                                                " enable better search
set ruler                                                   " show current line and column of cursor
set shiftround                                              " use multiple of shiftwidth when indenting with '<' and '>'
set shiftwidth=4                                            " number of spaces to use for autoindenting
set showmatch                                               " set show matching parenthesis
set smartcase                                               " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartindent                                             " reacts to syntax of code
set smarttab                                                " insert tabs on the start of a line according to shiftwidth, not tabstop
set tabstop=4                                               " a tab is four spaces
set title                                                   " change the terminal's title
set undolevels=1000                                         " use many muchos levels of undo
set visualbell t_vb=                                        " turn off error beep/flash
set wildignore=*.swp,*.bak,*.pyc,*.class                    " ignore files using search
set wildmenu                                                " visual autocomplete for command menu
set wildmode=longest:full,full                              " show long list
syntax on						                                        " highlight file syntax
