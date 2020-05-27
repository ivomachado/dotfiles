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
Plug 'jistr/vim-nerdtree-tabs' " Pacote do tree view
Plug 'editorconfig/editorconfig-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', {'do': './install.sh'}
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-abolish'
Plug 'moll/vim-bbye' "Buffer management
Plug 'rbong/vim-crystalline'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'wincent/ferret'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/headerguard'

Plug 'edkolev/tmuxline.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'NLKNguyen/papercolor-theme'

Plug 'majutsushi/tagbar'
" Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

call plug#end()

" set list listchars=tab:→\s,eol:¬,trail:␣,extends:>,precedes:<
set list listchars=eol:¬,tab:→\ ,trail:·,extends:>,precedes:<
set mouse=a
set noshowmode
set nobackup
set title
set hidden
set relativenumber
set number
set noswapfile
set wildignore+=*/tmp/*,*.swp,*.zip,*.exe,*/node_modules/*,*/build/*,*/.ccls-cache/*,*/.clangd/*,*/.build/*,*gradle*,*/.build*/*,*/output/*
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
nnoremap <leader>, :tabnew ~/.config/nvim/init.vim<CR>
nmap <leader>b :NERDTreeTabsToggle<CR>
nnoremap <leader>q :Bdelete<CR>
nnoremap <leader>Q :bdelete<CR>
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nmap <leader>t :TagbarOpenAutoClose<CR>
nnoremap <silent> <C-k><C-w> :bufdo :bd<CR>

nmap <leader>. <Plug>(coc-fix-current)
nmap <F2> <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>o :CtrlPBufTag<CR>
nmap <leader>p :CtrlPBuffer<CR>
inoremap <silent><expr> <c-space> coc#refresh()
nmap <leader>rea <C-w>h<C-w>J<C-w>k<C-w>l<C-w>L
nmap <leader>hftest p^ceFRIEND_TEST<esc>$r;X>>
nmap <leader>sg yyjpojkkkk hget4j hsetyy wlojkp<  iset wh2j
nmap <leader>hget ^iinline jk$s const {}jkk$BByeoreturn ";jkk$Bhi()jkhXbgUllbigetjk
nmap <leader>hset ^^yst;)$hXIvoid jk$Bye0f($h%PbgUllhisetjk
nmap <leader>iset 0$F(b"cPa::jk$s {}jkk$Byeo"_ = ";jk
nmap <leader>cs :'a,'bS#
nmap <C-w>M :NERDTreeClose<CR><C-w>\|<C-w>_
nmap <space> <leader>

set colorcolumn=80
colorscheme PaperColor

autocmd FileType c,cpp setlocal commentstring=//\ %s

let g:NERDTreeChDirMode       = 2
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '.git'
let g:ctrlp_extensions = ['buffertag']
let NERDTreeShowLineNumbers=1
let g:NERDTreeRespectWildIgnore=1
let g:ctrlp_show_hidden=1
let g:ctrlp_by_filename=1
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'fd --type f --color=never "" %s | head -n 10000'
" let g:ctrlp_user_command = {
"   \ 'types': {
"       \ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
"   \ },
"   \ 'ignore': 1
" \ }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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
    let l:s .= ' %{&ft}[%{&enc}][%{&ffs}]'
  else
    let l:s .= ' '
  endif

  if a:current
      let l:s .= ' %l/%L %c %P '
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
set autoread

command! RemoveIostream g/iostream\|cout/d
