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
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree' " Pacote do tree view
Plug 'Yggdroot/indentLine' " Pacote para mostrar indentação
Plug 'editorconfig/editorconfig-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sleuth'
Plug 'moll/vim-bbye' "Buffer management
Plug 'rbong/vim-crystalline'
Plug 'brooth/far.vim'

Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clangd-complete' }

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-obsession'
Plug 'euclio/gitignore.vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'michaeljsmith/vim-indent-object'

Plug 'edkolev/tmuxline.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'NLKNguyen/papercolor-theme'

Plug 'majutsushi/tagbar'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

call plug#end()

set list listchars=tab:>-,eol:¬,trail:.,extends:>
set mouse=a
set noshowmode
set nobackup
set title
set hidden
set relativenumber
set number
set noswapfile
" set wildignore+=*/tmp/*,*.swp,*.zip,*.exe,*/node_modules/*,*/build/*
set encoding=utf-8
set fileencoding=utf-8
set nowrap
set guioptions=
set guifont=Fira_Code:h10
set splitbelow
set splitright
set ignorecase
set smartcase
set hlsearch
set incsearch
set expandtab
set tabstop=4
set shiftwidth=4
set conceallevel=0
set eol
set fixendofline
set cursorline
set background=light
filetype plugin on

inoremap jk <Esc>
tnoremap jk <c-\><c-n>
map <leader>w <c-w>
nnoremap <leader>, :e ~/.config/nvim/init.vim<CR>
nmap <leader>b :NERDTreeToggle<CR>
nnoremap <leader>q :Bdelete<CR>
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nmap <leader>t :TagbarOpenAutoClose<CR>
nnoremap <silent> <C-k><C-w> :bufdo :bd<CR>
nmap ycm :YcmCompleter 
nmap <F2> "zyiw :YcmCompleter RefactorRename <C-r>z
nnoremap <silent> gd :YcmCompleter GoTo<CR>
nmap <leader>o :CtrlPBufTag<CR>
nmap <leader>p :CtrlPBuffer<CR>
nmap <leader>. :YcmCompleter FixIt<CR>
nmap <leader>rea <C-w>h<C-w>J<C-w>k<C-w>l<C-w>L
nmap <C-w>M <C-w>\|<C-w>_
nnoremap <C-t> :tabnew<CR>
nmap <space> <leader>

set colorcolumn=80
colorscheme PaperColor

autocmd FileType help,nerdtree IndentLinesDisable
autocmd FileType c,cpp setlocal commentstring=//\ %s
autocmd FocusGained,BufEnter * :silent! !

let g:NERDTreeChDirMode       = 2
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '.git'
let g:ctrlp_extensions = ['buffertag']
let NERDTreeShowLineNumbers=1
let g:NERDTreeRespectWildIgnore = 1
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_enabled = 0
let g:vim_json_syntax_conceal = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:far#file_mask_favorites = ['%', '**/*.*', '**/*.cpp', '**/*.h']
let g:ctrlp_show_hidden = 1

function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'papercolor'

set showtabline=2
set guioptions-=e
set laststatus=2
