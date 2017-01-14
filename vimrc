"This is Vim, not Vi
set nocompatible

"Don't try to identify filetype of things that don't have filetype on declared
filetype off

"Setup the vundles!
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

"manage vundle with vundle
Plugin 'gmarik/Vundle.vim'

"Shows the git diff status in the 'gutter' column
Plugin 'airblade/vim-gitgutter'
"The solarized color scheme
Plugin 'altercation/vim-colors-solarized'
"Airline, a light version of Powerline, a status line on steriods
Plugin 'bling/vim-airline'
"TOML Syntax, used by Rust's Cargo
Plugin 'cespare/vim-toml'
"Mirror of the official golang vim bundle
Plugin 'jnwhiteh/vim-golang'
"Coffee Script  syntax, indenting, compiling, and more.
Plugin 'kchmck/vim-coffee-script'
"Ctrl-P, a fuzzy finder for vim
Plugin 'kien/ctrlp.vim'
"Ack plugin, like Ackmate but for Vim
Plugin 'mileszs/ack.vim'
"Adds the Jellybeans color scheme
Plugin 'nanotech/jellybeans.vim'
"Sytnax etc for Handlebars templates
Plugin 'nono/vim-handlebars'
"Bats file highlighting
Plugin 'rosstimson/bats.vim'
"Visualize your undo tree (:GundoToggle)
Plugin 'sjl/gundo.vim'
"comment stuff out like a pro
Plugin 'scrooloose/nerdcommenter.git'
"textmate-like file browser drawer
Plugin 'scrooloose/nerdtree.git'
"super awesome syntax checking plugin
Plugin 'scrooloose/syntastic.git'
"adds end where you might want it in ruby (like if, def, etc)
Plugin 'tpope/vim-endwise'
"awesome unix-y vim commands, including :SudoWrite
Plugin 'tpope/vim-eunuch.git'
"In-vim git wrapper, :Gblame, etc
Plugin 'tpope/vim-fugitive'
"syntax, indent, and filetype for git*
Plugin 'tpope/vim-git'
"Vim syntax for markdown
Plugin 'tpope/vim-markdown'
"tons of commands to Vim up the Rails, so awesome!!
Plugin 'tpope/vim-rails'
"extends the . command to also repeat plugin commands (not just native)
Plugin 'tpope/vim-repeat'
"Helpers for surounding quotes/brackets
Plugin 'tpope/vim-surround'
"Ruby syntax etc. for vim
Plugin 'vim-ruby/vim-ruby'
"Awesome buffer explorer
Plugin 'vim-scripts/bufexplorer.zip'
"Noone likes you delimitMate! (automatically adds closing parens and such)
"Plugin 'vim-scripts/delimitMate.vim'
"shows 'Nth match out of M'
Plugin 'vim-scripts/IndexedSearch'
"Extends % to do the right thing in HTML & LaTeX among others
Plugin 'vim-scripts/matchit.zip'
"Rust syntax & indent settings
Plugin 'wting/rust.vim'
"React syntax & indent (requires vim-javascript)
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'

" All plugins specified
call vundle#end()

"load ftplugins and indent files
filetype plugin indent on

"turn on syntax highlighting
syntax on

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set number      "show line numbers

"display tabs and trailing spaces, plus make long lines more obvious
set list
set listchars=tab:▷⋅,trail:.,nbsp:⋅,extends:>,precedes:<

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

if v:version >= 703
  "undo settings
  set undodir=~/.vim/undofiles
  set undofile

  set colorcolumn=+1 "mark the ideal max text width
endif

"indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent

"folding settings (I don't really use folding, but here these are...)
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"set terminal to 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

"always show the status line
set laststatus=2

"vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

"ctrlp settings
let g:ctrlp_map = '<Leader>p'

"syntastic settings
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_checkers = ['eslint']

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
let g:NERDTreeIgnore=['\.DS_Store$', '\.vim$', '\.rbc$', '\~$']
let g:NERDTreeMapOpenSplit = 'i'

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" JELLYBEANS!
colorscheme jellybeans

"GUI Options?
"don't ever have the toolbar
set guioptions-=T
"don't have scrollbars all the time
set guioptions-=r
set guioptions-=L
"font font font with powerline support
set guifont=Anonymous\ Pro\ for\ Powerline:h16

"no backup or swap files please
set nobackup
set noswapfile

"use visualbell instead of audible bell, but set it to do nothing
set visualbell
set t_vb=

"automatically reread files that are changed outside of vim
set autoread

"set the leader to comma
let mapleader = ","

"stop wrappin'
set nowrap

"Map capital W to lower case w because fast fingers
command W w

"get rid of all that wailing trightspace.
map  <Leader>wt      :%s/\v\s+$//<CR>
map! <Leader>wt <esc>:%s/\v\s+$//<CR>i

"shortcuts for Buffer Explorer and NERDTree
nnoremap <Leader>b :BufExplorer<cr>
nnoremap <Leader>n :NERDTreeToggle<cr>
nnoremap <Leader>N :NERDTreeFind<cr>

"never ever use balloons for really reals
if has('gui_running')
  set noballooneval
  set balloonexpr=
  setlocal balloonexpr=
  set balloondelay=100000
  autocmd BufNewFile,BufRead * set balloonexpr=
  let g:syntastic_enable_balloons = 0
endif

"make git gutter more performant by only updating focused tab
let g:gitgutter_eager = 0
