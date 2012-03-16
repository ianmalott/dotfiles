set nocompatible " enable vim specific commands


"""
""" Vundle
"""

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'gmarik/vundle'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'

filetype plugin indent on " required


"""
""" Plugins
"""

runtime macros/matchit.vim


"""
""" Options
"""

let mapleader=',' " change mapleader from \ to ,
set background=dark
set backspace=indent,eol,start " backspace over these
set nobackup
set nocindent " c-style indenting
set nocursorline " highlight current line
set noeb " disable error bells
set expandtab " replace tabs with spaces
set fileformat=unix " use the unix fileformat
set hidden " enable hidden files
set history=1000 " length of command line history
set hlsearch " highlight last search
set ignorecase " case insensitive search; see smartcase below
set incsearch " show partial searches real-time
set laststatus=2
set magic " enable advanced regular expression in searches
set rnu " set line numbering off
set noruler " show the cursor position in the bottom right corner
set numberwidth=2 " characters allotted for line numbers
set shiftwidth=2 " number of spaces used with (auto)indention
set showcmd " display incomplete commands
set showmatch " flash matching () {} []
set smartcase " case insensitive except with initial capital
set softtabstop=2
set smartindent
set statusline=%F%m%r%h%w\ \|\ %{&ff}\ \ %Y\ \ (%l,%v)\ \ %p%%
set noswapfile
set tabpagemax=15 " max number of tabs
set tabstop=2 " tab size
set novb " don't blink the screen when there is an error
set wildmenu


"""
""" Colors
"""

colorscheme solarized
syn on " automatic syntax hilighting
hi statusline ctermbg=green ctermfg=black cterm=none
hi statuslinenc ctermbg=black ctermfg=green cterm=none
hi vertsplit ctermbg=black ctermfg=black cterm=none


"""
""" Abbreviations
"""

iab _NAME Ian Si Malott
iab _DATE =strftime("%A, %B %e %Y %I:%M:%S %p %Z")


"""
""" Keyboard mapping
"""

" Easier window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map j and k to work with wrapped lines
nnoremap j gj
nnoremap k gk

" Turn off search highlighting more easily
nmap <silent> ,/ :nohlsearch<CR>

" Easy vimrc management
map <leader>edit :vsp $HOME/.vimrc<cr>  " open .vimrc in a split window
map <leader>source :w<cr> :source $HOME/.vimrc<cr> " save and reload .vimrc

" Code review shortcut for screen
nnoremap <leader>review :call <SID>ReviewFile()<CR>

" Search for lines over 80 columns
nnoremap <leader>ll /.\{80\}.\+<CR>

" Open TODO topic heading
nnoremap <leader>th O<ESC>80i-<ESC>o<ESC>78i`<ESC>O

" Toggle paste
nnoremap <leader>paste :set invpaste paste?<CR>
set pastetoggle=<leader>paste
set showmode

" Press F5 to strip trailing whitespace
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Save with sudo
cmap w!! w !sudo tee % >/dev/null

" Search for visually selected text, forwards or backwards
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


"""
""" Functions
"""

function! ConvertDos()
  execute ":%s/^M//ge"
endfunction

function! <SID>ReviewFile()
  :silent !screen -S $PROJECT -p 1 -X stuff 'vim <cfile>'
  :silent !screen -S $PROJECT -p 0 -X stuff 'git diff master <cfile>'
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
