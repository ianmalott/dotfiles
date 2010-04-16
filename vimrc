"""
""" Options
"""

colors ir_black

filetype indent plugin on

set backspace=indent,eol,start " backspace over these
set nocindent " c-style indenting
set nocompatible  " enable vim specific commands
set cursorline " highlight current line
set noeb " disable error bells
set expandtab  " replace tabs with spaces
set fileformat=unix  " use the unix fileformat
set hidden " enable hidden files
set history=400 " keep 100 lines of command line history
set hlsearch " highlight last search
set ignorecase " case insensitive search; see smartcase below
set incsearch " show partial searches real-time
set laststatus=2
set magic " enable advanced regular expression in searches
set nonu  " set line numbering off
set noruler " show the cursor position in the bottom right corner
set shiftwidth=2 " number of spaces used with (auto)indention
set showcmd  " display incomplete commands
set showmatch " flash matching () {} []
set smartcase " case insensitive except with initial capital
set softtabstop=2
set smartindent
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

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"map <m-k> <c-w>k<c-w>_<c-w><bar> " go one window up and maximize it
"map <m-j> <c-w>j<c-w>_<c-w><bar> " go one window down and maximize it
"map <m-h> <c-w>h<c-w>_<c-w><bar> " go one window left and maximize it
"map <m-l> <c-w>l<c-w>_<c-w><bar> " go one window right and maximize it

map ,edit :sp $HOME/.vimrc<cr>  " open .vimrc in a split window
map ,source :w<cr> :source $HOME/.vimrc<cr> " save and reload .vimrc

" Press F5 to strip trailing whitespace
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

"""
""" Functions
"""

function! ConvertDos()
  execute ":%s/^M//ge"
endfunction

function! <SID>StripTrailingWhitespaces()
  " Save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Strip trailing whitespace, suppressing no-match error
  %s/\s\+$//e

  " Restore
  let @/=_s
  call cursor(l, c)
endfunction


"""
""" Auto Commands
"""

if has("autocmd")
  " Whitespace preferences
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif
