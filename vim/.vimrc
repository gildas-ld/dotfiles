""Vimrc
" Plugins

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" :CocInstall coc-tsserver
" :CocInstall coc-python
" :CocInstall coc-clangd
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

let g:jedi#auto_vim_configuration = 1
let g:jedi#environment_path = "/usr/bin/python3.12"
let g:jedi#popup_select_first = 0
let g:jedi#use_splits_not_buffers = "left"
let g:python3_host_prog = '/usr/bin/python3.12'

source ~/vim/plugins/commentary.vim
source ~/vim/plugins/shfmt.vim
source ~/vim/plugins/surround.vim
source ~/vim/plugins/nnn/plugin/nnn.vim

"NNN
let g:nnn#set_default_mappings = 0
" Set custom mappings
nnoremap <silent> <leader>nn :NnnPicker<CR>
" Start n³ in the current file's directory
nnoremap <leader>n :NnnPicker %:p:h<CR>
" Opens the n³ window in a split
let g:nnn#layout = 'new' " or vnew, tabnew etc.
" Or pass a dictionary with window size
let g:nnn#layout = { 'left': '~20%' } " or right, up, down
" Floating window. This is the default
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }

filetype plugin indent on
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Spell commands
nmap ?n ]s
nmap ?p [s
nmap ?+ zg
nmap ?? z=

" jump to start/end of line
noremap H ^
noremap L $

set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
"" ----------------
"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>
if has('macunix')
    " pbcopy for OSX copy/paste
    vmap <C-x> :!pbcopy<CR>
    vmap <C-c> :w !pbcopy<CR><CR>
endif
"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
"" Close buffer
noremap <leader>c :bd<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" javascript
" vim-javascript
augroup vimrc-javascript
    autocmd!
    autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

set cinoptions=(0,u0,U0,t0,g0,N-s

if has("autocmd")
    ""Creating parent directories on save
    " autocmd BufWritePre * :silent sudo !mkdir -p %:p:h
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd Filetype html setlocal ts=2 sw=2 expandtab
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    " autocmd BufWritePost * call system('sudo chown -R 1000:1000 ~/.local/share/vim/*')
                \}
    " CoC configuration for Python and JavaScript
    autocmd FileType python setlocal omnifunc=v:lua.vim.lsp.omnifunc
    autocmd FileType javascript setlocal omnifunc=v:lua.vim.lsp.omnifunc
    autocmd BufRead,BufNewFile * set tags+=./tags;
endif
" spacebar create/open/close folding
nmap <silent> <Space> za
vmap <silent> <Space> zf

""search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv
""-- file type detection --
syntax on
syntax enable
highlight LineNR cterm=none ctermfg=Yellow ctermbg=none
highlight CursorLineNR cterm=bold ctermfg=Blue ctermbg=none
filetype on  "/!\ doesn't play well with compatible mode
filetype plugin on  "trigger file type specific plugins
filetype indent on  "indent based on file type syntax
set guifont=Consolas\ 16
""Remapping !!!
"This unsets the 'last search pattern' register by hitting return
noremap <CR> :noh<CR>:<backspace>
"Create file under cursor if not exists
:noremap <leader>gf :e <cfile><cr>
"scroll slightly faster
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
map <C-Up> <C-y>
map <C-Down> <C-e>
""reload vim config
noremap  <leader>rv :source $MYVIMRC<CR>
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
""Move lines around
nnoremap  <C-UP> ddkP
nnoremap  <C-DOWN> ddp
vnoremap  <C-UP> xkP`[V`]
vnoremap  <C-DOWN> xp`[V`]
nnoremap  <C-UP>  :<C-u>silent! move-2<CR>==
nnoremap  <C-DOWN>  :<C-u>silent! move+<CR>==
xnoremap  <C-UP>  :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap  <C-DOWN>  :<C-u>silent! '<,'>move'>+<CR>gv=gv
nnoremap ,<Up>  :<C-u>silent! move-2<CR>==
nnoremap ,<Down> :<C-u>silent! move+<CR>==
xnoremap ,<Up>  :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap ,<Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv
"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>g :Ack
""map <leader>o :only <C-R><CR>
map <leader>e :e <C-R>=substitute(expand("%:p:h") . "/", "", "\\\\ ", "g")<CR>
map <leader>T :tabe <C-R>=substitute(expand("%:p:h") . "/", "", "\\\\ ", "g")<CR>
map <leader>s :split <C-R>=substitute(expand("%:p:h") . "/", "", "\\\\ ", "g")<CR>
map <leader>v :vsplit <C-R>=substitute(expand("%:p:h") . "/", "", "\\\\ ", "g")<CR>
map <leader>c :cd <C-R>=substitute(expand("%:p:h") . "/", "", "\\\\ ", "g")<CR>
map <leader>n :new <cfile><CR>
""Resize splits more quickly
nnoremap <silent> <Leader>+ :exe "resize ". (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize ". (winheight(0) * 2/3)<CR>
""Switch Windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
""Surround the visual selection in parenthesis/brackets/etc
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>
""Insert mode mappings
""Quickly insert parenthesis/brackets/etc.:
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i
""Insert the current date and time
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
inoremap jj <Esc>
imap <S-Space> <Esc>
imap ;; <Esc>
nnoremap <C-space> i
imap <F2> <ESC>:set invpaste<CR>:set paste?<CR>gi
imap <C-space> <Esc>
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>" viw<esc>a"<esc>hbi"
nnoremap <leader>( viw<esc>a)<esc>hbi(
"Mappings to toggle folds
nnoremap <F2> :set invpaste paste?<CR>
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
""Abbreviations
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Qall qall
cnoreabbrev Qall! qall!
cnoreabbrev W w
cnoreabbrev W! w!
cnoreabbrev WQ wq
cnoreabbrev Wa wa
cnoreabbrev Wq wq
cnoreabbrev wQ wq
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
if &term =~ '256color'
    set t_ut=
endif
""Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
""Copy/Paste/Cut
set clipboard=unnamed,unnamedplus
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>
noremap <leader>pp :setlocal paste!<cr>
""Set working directory
nnoremap <leader>. :lcd %:p:h<CR>
""Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
""Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>
""Close buffer
noremap <leader>c :bd<CR>
""Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>
""Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
""Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
cnoremap <C-P> <C-R>=expand("%:p:h") . "/"<CR>

" set text wrapping toggles
nmap <silent> tw :set invwrap<cr>:set wrap?<cr>

"" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
""Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/"<CR>
""Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/"<CR>
augroup vimrc
    au BufReadPre * setlocal foldmethod=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
" if exists('+undodir')
"    if !empty($XDG_DATA_HOME)
"        let s:data_home = substitute($XDG_DATA_HOME, '/$', '', '') . '/vim/'
"    elseif has('win32')
"        let s:data_home = expand('~/AppData/Local/vim/')
"    else
"        let s:data_home = expand('~/.local/share/vim/')
"    endif
"    let &undodir = s:data_home . 'undo//'
"    let &directory = s:data_home . 'swap//'
"    let &backupdir = s:data_home . 'backup//'
"    if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif
"    if !isdirectory(&directory) | call mkdir(&directory, 'p') | endif
"    if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p') | endif
"endif
" Section: Reading and writing files
if has('multi_byte')
    let &g:fileencodings = substitute(&fileencodings, 'latin1', 'cp1252', '')
endif
if exists('##CursorHold')
    autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
                \ if !$VIMSWAP && isdirectory(expand('<amatch>:h')) | let &swapfile = &modified | endif
endif
" set undodir=~/.vim/undodir

" I use a unicode curly array with a <backslash><space>
" set nowrap sidescroll=1 listchars=extends:>,precedes:<
" set titlestring=%F
let mapleader=","
let maplocalleader="," "change local leader key to ,

set autochdir
set autoindent "Turns on auto-indenting"
set autoread
set autowrite
set backspace=indent,eol,start
set breakindent
set breakindentopt=sbr
set cinoptions=(0,u0,U0,t0,g0,N-s
set clipboard=unnamedplus
set colorcolumn=0
set complete-=i     " Searching includes can be slow
set confirm
set copyindent "Copy the previous indentation on autoindenting"
set cursorline "cursorlineopt=number Highlight line number"
set diffopt+=horizontal
set display=lastline
set encoding=utf-8
set expandtab "Turns tabs into spaces
"set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set foldlevel=99
set foldlevelstart=99
set formatoptions-=o "don't start new lines w/ comment leader on pressing 'o'
set grepformat=%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f\ \ %l%m
set hidden
set history=10000  "boost commands and search patterns history
set hlsearch
set iconstring=%{tolower(empty(v:servername)?v:progname\ :\ v:servername)}%{exists('$SSH_TTY')?'@'.hostname():''}
set ignorecase "Ignores case when searching"
set incsearch "Highlights search terms as you type them
set infercase
set laststatus=2  "always show a status line
set linespace=0
set listchars=extends:>,precedes:<
set listchars=tab:\ \ ,extends:>,precedes:<,nbsp:·,trail:\\
set mouse=a
set mousemodel=popup
set nocompatible
set nofoldenable  "don't fold by default
set nomodeline  "disable mode lines (security measure)
set nostartofline
set noswapfile
set nrformats-=octal
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<F2>
set path+=**
set path=.,,
set rtp+=/usr/local/opt/fzf
set ruler
set scrolloff=3
set sessionoptions-=buffers sessionoptions-=curdir sessionoptions+=sesdir,globals
set shiftround
set shiftwidth=4
set showbreak=↪>\
set showcmd
set showmatch "Highlights matching parentheses"
set showmode
set showtabline=2
set sidescroll=0
set smartcase "Unless you put some caps in your search term"
set smarttab
set softtabstop=0
set spelllang=fr
set splitbelow
set splitright
set startofline
set statusline=\ ☠\ %F%m%r%h%w\ (%{&ff}/%Y)\ ⚐\ %y%m%r%*\ ❑\ %n%=✎\ %(%l:%c\%)\ ⇨\ %P
set t_Co=256
set tabstop=4
set tags+=./tags;
set termencoding=utf-8
set title
set titleold="Terminal"
set titlestring=%{v:progname}\ %{tolower(empty(v:servername)?'':'--servername\ '.v:servername.'\ ')}%{fnamemodify(getcwd(),':~')}%{exists('$SSH_TTY')?'\ <'.hostname().'>':''}
set ttimeout
set ttimeoutlen=100
set ttyfast
set undofile
set undolevels=1000 "boost undo levels
set viminfo=!,'100,<250,s50,h
set virtualedit=block
set visualbell
set whichwrap=<,>,[,]
set wildchar=<TAB>  "show possible completions.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/,tags,.*.un~,*.pyc
set wildignorecase
set wildmenu
set wildmode=list:longest,list:full
set winaltkeys=no
set wrap

""=  : (re)indent the text on the current line or on the area selected (SUPER)
""=%  : (re)indent the current braces { ... }
""~  : invert case (upper->lower; lower->upper) of current character
""CTRL-A,CTRL-X : increment, decrement next number on same line as the cursor
""CTRL-R=5*5  : insert 25 into text
""G=gg  : auto (re)indent entire document
""g8  : display hex value of utf-8 character under cursor
""ga  : display hex, ascii value of character under cursor
""gf  : open file name under cursor (SUPER)
""ggg?G  : rot13 whole file
""guu  : lowercase line
""gUU  : uppercase line
""vim -V20 2>&1 | tee logfile # debug
""xp  : swap next two characters around
" vim:set et sw=2 foldmethod=expr
