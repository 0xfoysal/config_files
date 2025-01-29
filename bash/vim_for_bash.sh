#!/bin/bash

# Ensure vim is installed
if ! command -v vim &> /dev/null; then
    echo "Vim is not installed. Installing Vim..."
    sudo apt-get update
    sudo apt-get install -y vim
fi

# Ensure git is installed (required for plugin managers)
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    sudo apt-get install -y git
fi

# Install Vim plugin manager (vim-plug)
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Create or update .vimrc with recommended plugins
echo "Configuring .vimrc with plugins for Bash programming..."
cat > ~/.vimrc <<EOL
" Enable filetype detection, plugins, and indentation
filetype plugin indent on

" Use vim-plug to manage plugins
call plug#begin('~/.vim/plugged')

" Plugins for Bash programming
Plug 'vim-syntastic/syntastic'          " Syntax checking
Plug 'pangloss/vim-javascript'          " JavaScript syntax (optional)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go support (optional)
Plug 'tpope/vim-fugitive'               " Git integration
Plug 'airblade/vim-gitgutter'           " Git diff in the gutter
Plug 'scrooloose/nerdtree'              " File explorer
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git status in NERDTree
Plug 'vim-airline/vim-airline'          " Status bar
Plug 'vim-airline/vim-airline-themes'   " Themes for vim-airline
Plug 'jiangmiao/auto-pairs'             " Auto-close brackets, quotes, etc.
Plug 'tpope/vim-commentary'             " Commenting support
Plug 'sheerun/vim-polyglot'             " Language pack for syntax highlighting
Plug 'dense-analysis/ale'               " Asynchronous Lint Engine
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' } " Autocompletion

call plug#end()

" Enable syntax highlighting
syntax on

" Set line numbers
set number

" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Enable mouse support
set mouse=a

" Configure Syntastic
let g:syntastic_bash_checkers = ['shellcheck']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Configure ALE
let g:ale_linters = {
\\ 'bash': ['shellcheck'],
\\}

" Configure YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Configure NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Configure vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'minimalist'

EOL

# Install plugins
echo "Installing Vim plugins..."
vim +PlugInstall +qall

echo "Vim plugins for Bash programming have been installed and configured!"