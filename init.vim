set nocompatible

if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
elseif empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

call plug#begin()

Plug 'Xuyuanp/nerdtree-git-plugin' "Pacote de git do tree view
Plug 'airblade/vim-gitgutter' " Mostrar + e - e modificado do git ao lado do número de linha
Plug 'rhysd/conflict-marker.vim'
Plug 'christoomey/vim-conflicted'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree' " Pacote do tree view
Plug 'Yggdroot/indentLine' " Pacote para mostrar indentação
Plug 'editorconfig/editorconfig-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-sleuth'
Plug 'moll/vim-bbye' "Buffer management
Plug 'vim-airline/vim-airline'
Plug 'brooth/far.vim'

Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clang-complete' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-obsession'
Plug 'elzr/vim-json'
Plug 'vim-scripts/gitignore'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ap/vim-css-color'

Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'
Plug 'NLKNguyen/papercolor-theme'

Plug 'majutsushi/tagbar'
" Plug 'w0rp/ale'

call plug#end()


set list listchars=tab:>-,eol:¬,trail:.,extends:>


set noshowmode
set nobackup
set title
set hidden
set relativenumber
set number
set noswapfile
set wildignore+=*/tmp/*,*.swp,*.zip,*.exe,*/node_modules/*,*/build/*
set encoding=utf-8
set fileencoding=utf-8
set nowrap
set guioptions=
set guifont=Fira_Code:h10
set splitbelow
set splitright
set completeopt=menu
" set completeopt-=preview
" set complete=preview
set ignorecase
set smartcase
set hlsearch
set incsearch
set expandtab
set tabstop=4
set shiftwidth=4
" set t_Co=256
set eol
set fixendofline
filetype plugin on

inoremap jk <Esc>
tnoremap jk <c-\><c-n>
map <leader>w <c-w>
nnoremap <leader>, :e ~/.config/nvim/init.vim<CR>
nmap \b :NERDTreeToggle<CR>
" nmap <silent> [e <Plug>(ale_previous_wrap)
" nmap <silent> ]e <Plug>(ale_next_wrap)
nnoremap \q :Bdelete<CR>
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nmap <leader>t :TagbarOpenAutoClose<CR>
nnoremap <silent> <C-k><C-w> :bufdo :Bdelete<CR>
nmap ycm :YcmCompleter 
" nnoremap <silent> <leader>o :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gd :YcmCompleter GoTo<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nmap <leader>o :CtrlPBufTag<CR> 

set background=light
set colorcolumn=80
colorscheme codedark

let g:NERDTreeChDirMode       = 2
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'build\|.build\|third_party\|tools'
let g:ctrlp_extensions = ['buffertag']
let NERDTreeShowLineNumbers=1
let g:NERDTreeRespectWildIgnore = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:vim_json_syntax_conceal = 0
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_enabled = 0

let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:jsx_ext_required = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
