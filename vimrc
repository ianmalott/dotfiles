"""
""" Options
"""

colors ir_black
"colors elflord
"colors synic
"colors tango
"colors wombat
"colors fnaqevan

filetype indent plugin on

set backspace=indent,eol,start " backspace over these 
set nocindent " c-style indenting
set nocompatible  " enable vim specific commands
set cursorline " highlight current line
set noeb " disable error bells
set expandtab  " replace tabs with spaces
set fileformat=unix  " use the unix fileformat
set hidden " enable hidden files
set history=100 " keep 100 lines of command line history
set hlsearch " highlight last search
set ignorecase " case insensitive search; see smartcase below
set incsearch " show partial searches real-time
set laststatus=2
set magic " enable advanced regular expression in searches
set nonu  " set line numbering off
"set ruler " show the cursor position in the bottom right corner
set shiftwidth=2 " number of spaces used with (auto)indention
set showcmd  " display incomplete commands
set showmatch " flash matching () {} [] 
set smartcase " case insensitive except with initial capital
"set smartindent
set statusline=%F%m%r%h%w\ \|\ %{&ff}\ \ %Y\ \ (%l,%v)\ \ %p%%
set tabstop=2 " tab size
set novb " don't blink the screen when there is an error
set wildmenu

syn on " automatic syntax hilighting


"""
""" Abbreviations
"""

iab _NAME Ian Si Malott
iab _DATE =strftime("%A, %B %e %Y %I:%M:%S %p %Z")


"""
""" Keyboard remapping
"""

"map <c-k> <c-w>k " go one window up
"map <c-j> <c-w>j " go one window down
"map <c-h> :bp<cr>  " go to previous buffer
"map <c-l> :bn<cr> " go to next buffer
"map <m-k> <c-w>k<c-w>_<c-w><bar> " go one window up and maximize it
"map <m-j> <c-w>j<c-w>_<c-w><bar> " go one window down and maximize it
"map <m-h> <c-w>h<c-w>_<c-w><bar> " go one window left and maximize it
"map <m-l> <c-w>l<c-w>_<c-w><bar> " go one window right and maximize it

map ,edit :sp $HOME/.vimrc<cr>  " open .vimrc in a split window
map ,source :w<cr> :source $HOME/.vimrc<cr> " save and reload .vimrc


"""
""" Functions
"""

function! ConvertDos()
  execute ":%s/^M//g"
endfunction


"""
""" Auto Commands
"""

if has("autocmd")
  autocmd BufRead,BufNewFile *.py set shiftwidth=4
  autocmd BufRead,BufNewFile *.py set tabstop=4
  autocmd BufRead,BufNewFile *.py set shiftwidth=2
  autocmd BufRead,BufNewFile *.py set tabstop=2
endif

