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

Plug 'Xuyuanp/nerdtree-git-plugin' "Pacote de git do tree view
Plug 'airblade/vim-gitgutter' " Mostrar + e - e modificado do git ao lado do número de linha
Plug 'rhysd/conflict-marker.vim'
Plug 'christoomey/vim-conflicted'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree' " Pacote do tree view
Plug 'Yggdroot/indentLine' " Pacote para mostrar indentação
Plug 'editorconfig/editorconfig-vim'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-sleuth'
Plug 'moll/vim-bbye' "Buffer management
Plug 'vim-airline/vim-airline'
Plug 'brooth/far.vim'

Plug 'captbaritone/better-indent-support-for-php-with-html'
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
Plug 'fenetikm/falcon'
Plug 'tomasiser/vim-code-dark'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-two-firewatch'
Plug 'jacoborus/tender.vim'
Plug 'jonathanfilip/vim-lucius'

Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}

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
nnoremap <leader>o :e ~/.config/oni/config.tsx<CR>
nmap \b :NERDTreeToggle<CR>
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
nnoremap \q :Bdelete<CR>
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nmap <leader>t :TagbarOpenAutoClose<CR>
" nnoremap <silent> gh :LspHover<CR>
" nnoremap <silent> gd :LspDefinition<CR>
" nnoremap <silent> gr :LspReferences<CR>
" nnoremap <silent> <leader>o :LspDocumentSymbol<CR>
" nnoremap <silent> <leader>o :CtrlPBufTag<CR>
" nnoremap <silent> <F2> :LspRename<CR>
nnoremap <silent> <C-k><C-w> :bufdo :Bdelete<CR>
nnoremap <silent> <leader>o :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" inoremap <C-Space> <C-X><C-O>
" imap <c-space> <Plug>(asyncomplete_force_refresh)

colorscheme PaperColor

let g:NERDTreeChDirMode       = 2
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['buffertag']
let NERDTreeShowLineNumbers=1
let g:NERDTreeRespectWildIgnore = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'python':     ['pylint']
\}
let g:indentLine_leadingSpaceEnabled = 1
let g:vim_json_syntax_conceal = 0
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_enabled = 0
let g:LanguageClient_serverCommands = {
            \ 'javascript': ['typescript-language-server', '--stdio'],
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ 'css':        ['css-languageserver', '--stdio'],
            \ 'go':         ['go-langserver'],
            \ 'cpp':        ['clangd'],
            \}
let g:LanguageClient_diagnosticsEnable = 'Disabled'
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:jsx_ext_required = 1


autocmd BufNewFile,BufRead *.js set ft=javascript
autocmd BufNewFile,BufRead *.js vnoremap <leader>f :'<,'> call RangeJsBeautify()<CR>
autocmd BufNewFile,BufRead *.js nnoremap <leader>f :call JsBeautify()<CR>
autocmd CompleteDone * pclose!

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

" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = ''
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

" if executable('typescript-language-server')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'typescript-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
"         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
"         \ 'whitelist': ['typescript'],
"         \ })


"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'javascript-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
"         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'jsconfig.json'))},
"         \ 'whitelist': ['javascript'],
"         \ })
" endif

" if executable('css-language-server')
"   au User ls_setup call lsp#register_server({
"         \'name': 'css-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-language-server --stdio']},
"         \ 'whitelist': ['css'],
"         \ })

" endif

" au User lsp_setup call lsp#register_server({
"      \ 'name': 'php-language-server',
"      \ 'cmd': {server_info->['php', expand('~/.config/nvim/plugged/php-language-server/bin/php-language-server.php')]},
"      \ 'whitelist': ['php'],
"      \ })

" if executable('pyls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'css': ['css-language-server', '--stdio'],
    \ }
let g:deoplete#enable_at_startup = 1
