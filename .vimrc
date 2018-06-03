set nocompatible

if has('nvim')
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
elseif empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'NLKNguyen/papercolor-theme' "Tema que eu uso
Plug 'Xuyuanp/nerdtree-git-plugin' "Pacote de git do tree view
Plug 'Yggdroot/indentLine' " Pacote para mostrar indentação
Plug 'mhinz/vim-signify' " Mostrar + e - e modificado do git ao lado do número de linha
Plug 'kien/ctrlp.vim' " Fuzzy Finder
Plug 'scrooloose/nerdtree' " Pacote do tree view
Plug 'sheerun/vim-polyglot'
Plug 'elzr/vim-json'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/gitignore'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'moll/vim-bbye' "Buffer management
Plug 'edkolev/tmuxline.vim'
Plug 'romainl/Apprentice'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/echodoc.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()


set list listchars=tab:>-,eol:¬,trail:.,extends:>


set noshowmode
set nobackup
set title
set hidden
set relativenumber
set number
set noswapfile
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
set encoding=utf-8
set fileencoding=utf-8
set nowrap
set guioptions=
set guifont=Fira_Code:h10
set splitbelow
set splitright
" set completeopt-=preview
" set complete=
set ignorecase
set smartcase
set hlsearch
set incsearch
set expandtab
set tabstop=4
set shiftwidth=4
set t_Co=256
set eol
set fixendofline

filetype plugin on

inoremap jk <Esc>
map <leader>w <c-w>
nnoremap <leader>, :e ~/.vimrc<CR>
nmap \b :NERDTreeToggle<CR>
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
" nmap \o :CtrlPBufTag<CR>
nnoremap \q :Bdelete<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR> :lop<CR>
nnoremap <silent> <leader>o :call LanguageClient#textDocument_documentSymbol()<CR> :lop<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>



" let g:airline_powerline_fonts = 1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint']
\}
let g:indentLine_leadingSpaceEnabled = 1
let g:vim_json_syntax_conceal = 0
let g:LanguageClient_serverCommands = {
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ 'css':        ['css-languageserver', '--stdio'],
            \ 'go':         ['go-langserver'],
            \}
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_diagnosticsEnable = 'Quickfix'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_enabled = 0
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '>',
    \ 'right' : '',
    \ 'right_alt' : '<',
    \ 'space' : ' '}

autocmd BufNewFile,BufRead *.js set ft=javascript
autocmd CompleteDone * pclose!

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

