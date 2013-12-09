set nocompatible " enable vim specific commands


"""
""" Vundle
"""

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'elixir-lang/vim-elixir'
Bundle 'gmarik/vundle'
Bundle 'kana/vim-textobj-user'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'

filetype plugin indent on " required


"""
""" Plugins
"""

runtime macros/matchit.vim


"""
""" Variables
"""

let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " list files in CtrlP with Ag
let g:rails_ctags_arguments = "`gem env gemdir`/gems --exclude=tmp"
let mapleader=',' " use comma as leader


"""
""" Options
"""

set background=dark
set backspace=indent,eol,start " backspace over these
set nobackup
set nocindent " c-style indenting
set clipboard=unnamed " enable clipboard integration with Mac OS X
set cursorline " highlight current line
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
set relativenumber " use relative line numbers
set number " show absolute line number of current line
set noruler " show the cursor position in the bottom right corner
set numberwidth=2 " characters allotted for line numbers
set pastetoggle=<leader>paste " specify key sequence for toggling 'paste' option
set shiftround " round indent to multiple of 'shiftwidth'
set shiftwidth=2 " number of spaces used with (auto)indention
set showcmd " display incomplete commands
set showmatch " flash matching () {} []
set showmode " display current mode
set smartcase " case insensitive except with initial capital
set softtabstop=2
set smartindent
set statusline=%F%m%r%h%w\ \|\ %{&ff}\ \ %Y\ \ (%l,%v)\ \ %p%%
set noswapfile
set tabpagemax=15 " max number of tabs
set tabstop=2 " tab size
set novb " don't blink the screen when there is an error
set wildmenu " display options for tab completion in command mode
set wildmode=list:longest " tab completion up to point of ambiguity


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
iab <expr> _DATE strftime("%Y-%m-%d")


"""
""" Keyboard mapping
"""

" Save with sudo
cmap w!! w !sudo tee % >/dev/null

" Ignore lingering <shift> when writing a buffer to file
cmap W w

" Easier window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Easy vimrc management
map <leader>rc :e $HOME/.vimrc<cr>  " edit .vimrc
map <leader>vrc :vsp $HOME/.vimrc<cr>  " open .vimrc in a split window
map <leader>source :w<cr> :source $HOME/.vimrc<cr> " save and reload .vimrc

" Turn off search highlighting more easily
nmap <silent> <leader>/ :nohlsearch<CR>

" Map j and k to work with wrapped lines
nnoremap j gj
nnoremap k gk

" Yank path of current file
nnoremap <silent> <leader>yfp :let @+=expand("%")<CR>

" Code review shortcuts for screen
nnoremap <leader>df :call <SID>DiffFile()<CR>
nnoremap <leader>of :call <SID>OpenFile()<CR>
nnoremap <leader>rf :call <SID>ReviewFile()<CR>

" Search for lines over 100 columns
nnoremap <leader>ll /.\{100\}.\+<CR>

" Open TODO topic heading
nnoremap <leader>th O<ESC>80i-<ESC>o<ESC>78i`<ESC>O

" Toggle paste
nnoremap <leader>paste :set invpaste paste?<CR>

" Toggle relative line numbers
nnoremap <leader>rnu :set invrnu<CR>

" Strip trailing whitespace
nnoremap <leader>rstrip :call <SID>StripTrailingWhitespaces()<CR>
" Search for visually selected text, forwards or backwards

" Search for visually-selected text by typing '*'
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Search in reverse for visually-selected text by typing '#'
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

function! <SID>DiffFile()
  :silent !screen -p 0 -X stuff 'git diff master...head <cfile>'
endfunction

function! <SID>OpenFile()
  :silent !screen -p 1 -X stuff 'vim <cfile>'
endfunction

function! <SID>ReviewFile()
  :silent !screen -p 1 -X stuff 'vim <cfile>'
  :silent !screen -p 0 -X stuff 'git diff master...head <cfile>'
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

  " Treat RABL files as Ruby
  autocmd Bufenter *.rabl setfiletype ruby
endif
