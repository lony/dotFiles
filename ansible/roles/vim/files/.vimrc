"#### Plugins Installation
" https://github.com/junegunn/vim-plug
" To Install run :PlugInstall
" https://vimawesome.com/ - plugin search

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'

call plug#end()


"#### Settings
" http://nvie.com/posts/how-i-boosted-my-vim/
" https://dougblack.io/words/a-good-vimrc.html
" https://github.com/allinurl/dotfiles/blob/master/.vimrc

set nocompatible                " You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
syntax on						            " Highlight file syntax

" Ruby - Syntax Highlighting
" https://blog.arangamani.net/blog/2013/11/27/syntax-highlighting-in-vim-for-vagrantfile-gemfile-and-berksfile/
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby

" http://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
set clipboard=unnamed			" Enable clipboard copy and paste

" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
"set hidden

set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu
"set ruler

set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set novisualbell                " Turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " Turn off error beep/flash

set nobackup
set noswapfile

set foldenable                  " enable folding
set foldlevelstart=10           " open most folds by default
set foldnestmax=10              " 10 nested fold max

set encoding=utf-8
"set t_Co=256

" http://stackoverflow.com/questions/32103591/vim-cant-scroll-in-iterm2
set mouse=a
if has("mouse_sgr")
	set ttymouse=sgr
else
	set ttymouse=xterm2
end

" http://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
set pastetoggle=<F3>

"#### Plugins Configuration

" airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
