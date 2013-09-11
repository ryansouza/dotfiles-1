"This is Vim, not Vi
set nocompatible

"Don't try to identify filetype of things that don't have filetype on declared
filetype off

"Setup the vundles!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"manage vundle with vundle
Bundle 'gmarik/vundle'

"Shows the git diff status in the 'gutter' column
Bundle 'airblade/vim-gitgutter'
"The solarized color scheme
Bundle 'altercation/vim-colors-solarized'
"Mirror of the official golang vim bundle
Bundle 'jnwhiteh/vim-golang'
"Powerline, a status line on steriods
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Coffee Script  syntax, indenting, compiling, and more.
Bundle 'kchmck/vim-coffee-script'
"Ack plugin, like Ackmate but for Vim
Bundle 'mileszs/ack.vim'
"Adds the Jellybeans color scheme
Bundle 'nanotech/jellybeans.vim'
"Sytnax etc for Handlebars templates
Bundle 'nono/vim-handlebars'
"Visualize your undo tree (:GundoToggle)
Bundle 'sjl/gundo.vim'
"comment stuff out like a pro
Bundle 'scrooloose/nerdcommenter.git'
"textmate-like file browser drawer
Bundle 'scrooloose/nerdtree.git'
"super awesome syntax checking plugin
Bundle 'scrooloose/syntastic.git'
"Peepopen! Hurray!
Bundle 'topfunky/PeepOpen-EditorSupport', {'rtp': 'vim-peepopen/'}
"adds end where you might want it in ruby (like if, def, etc)
Bundle 'tpope/vim-endwise'
"awesome unix-y vim commands, including :SudoWrite
Bundle 'tpope/vim-eunuch.git'
"In-vim git wrapper, :Gblame, etc
Bundle 'tpope/vim-fugitive'
"syntax, indent, and filetype for git*
Bundle 'tpope/vim-git'
"Vim syntax for markdown
Bundle 'tpope/vim-markdown'
"tons of commands to Vim up the Rails, so awesome!!
Bundle 'tpope/vim-rails'
"extends the . command to also repeat plugin commands (not just native)
Bundle 'tpope/vim-repeat'
"Ruby syntax etc. for vim
Bundle 'vim-ruby/vim-ruby'
"Awesome buffer explorer
Bundle 'vim-scripts/bufexplorer.zip'
"Noone likes you matchit! (automatically adds closing parens and such)
"Bundle 'vim-scripts/delimitMate.vim'
"shows 'Nth match out of M'
Bundle 'vim-scripts/IndexedSearch'
"Extends % to do the right thing in HTML & LaTeX among others
Bundle 'vim-scripts/matchit.zip'
"Rust syntax & indent settings
Bundle 'wting/rust.vim'
"Bats file highlighting
Bundle 'rosstimson/bats.vim'

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

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"set terminal to 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

if has("statusline")
  set statusline=%<%F\ %#ErrorMsg#%{fugitive#statusline()}%#StatusLine#%=%([%M%R%H%W]\ %)%l,%c%V\ %P\ (%n)
  set laststatus=2
endif

"syntastic settings
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
let g:NERDTreeIgnore=['\.DS_Store$', '\.vim$', '.d$[[dir]]', '\.rbc$', '\~$']
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

" Vim-powerline
let g:Powerline_symbols = 'fancy'

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

"only ever show syntastic tooltips
if has('gui_running')
  set balloonexpr=SyntasticErrorBalloonExpr()
  autocmd FileType ruby set balloonexpr=SyntasticErrorBalloonExpr()
endif

"make git gutter more performant by only updating focused tab
let g:gitgutter_eager=0
