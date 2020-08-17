set nocompatible " enable vim-specific options

""" Vim-plug {{{
""
"

call plug#begin('~/.vim/plugged')
Plug 'DataWraith/auto_mkdir'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'kana/vim-textobj-user'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'lmeijvogel/vim-yaml-helper'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call plug#end()

"
""
""" }}}

""" Plugins Distributed with Vim {{{
""
"

runtime macros/matchit.vim

"
""
""" }}}

""" Variables {{{
""
"

let g:ctrlp_match_window = 'results:100' " results often clipped if not increased past max height
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " list files in CtrlP with Ag
let g:gitgutter_enabled = 0 " disable GitGutter by default (toggle with <leader>ggt or :GitGutterToggle)
let g:lightline = { 'colorscheme': 'solarized' } " use solarized colors for lightline
let g:rails_ctags_arguments = "--exclude=tmp --exclude=vendor"
let g:Tlist_Ctags_Cmd="ripper-tags -R"
let mapleader=',' " use comma as leader

"
""
""" }}}

""" Options {{{
""
"

set   autoindent
set   background=dark " used by solarized color scheme
set   backspace=indent,eol,start " backspace over these
set nobackup
set nocindent " c-style indenting
set   clipboard=unnamed " enable clipboard integration with Mac OS X
set   cursorline " highlight current line
set noerrorbells " disable error bells
set   expandtab " replace tabs with spaces
set   fileformat=unix " use the unix fileformat
set   foldmethod=marker " use default {{{ fold this }}} markers
set   hidden " enable hidden files
set   history=1000 " length of command line history
set   hlsearch " highlight last search
set   ignorecase " case insensitive search; see smartcase below
set   incsearch " show partial searches real-time
set   laststatus=2 " always show a status line
set   magic " use default escaping in search patterns (use /\vpattern for verymagic)
set   number " show absolute line number of current line
set   numberwidth=2 " characters allotted for line numbers
set nopaste " abbreviations don't work when paste mode is on
set   pastetoggle=<leader>paste " specify key sequence for toggling 'paste' option
set   relativenumber " use relative line numbers
set noruler " show the cursor position: (line, column)
set   shiftround " round indent to multiple of 'shiftwidth'
set   shiftwidth=2 " number of spaces used with (auto)indention
set   showcmd " display info about in-progress commands, e.g. selecting text
set   showmatch " flash matching () {} []
set   showmode " display current mode
set   smartcase " case insensitive except with initial capital
set nosmartindent " use autoindent instead
set   softtabstop=2
set   splitbelow " open horizontal splits below instead of above
set   splitright " open vertical splits to the right instead of to the left
set   statusline=%F%m%r%h%w\ \|\ %{&ff}\ \ %Y\ \ (%l,%v)\ \ %p%%
set noswapfile
set   t_BE= " disable bracketed paste mode to prevent <PasteStart>pasted<PasteEnd>
set   tabpagemax=15 " max number of tabs
set   tabstop=2 " tab size
set   updatetime=250 " write to swap after 250ms idle (default: 4000ms)
set novisualbell " don't blink the screen when there is an error
set   wildmenu " display options for tab completion in command mode
set   wildmode=list:longest " tab completion up to point of ambiguity

"
""
""" }}}

""" Colors {{{
""
"

colorscheme solarized
syn on " automatic syntax hilighting
hi statusline ctermbg=green ctermfg=black cterm=none
hi statuslinenc ctermbg=black ctermfg=green cterm=none
hi vertsplit ctermbg=black ctermfg=black cterm=none

"
""
""" }}}

""" Abbreviations {{{
""
"

iab _NAME Ian Si Malott
iab <expr> _DATE strftime("%Y-%m-%d")

"
""
""" }}}

""" Mappings {{{
""
"

" Base mapping command modes
" map         normal, visual, and operator-pending; recursive
" noremap     normal, visual, and operator-pending; non-recursive

" Mapping command prefix modes
" c           command-line
" i           insert
" l           lang-arg (when typing yields text not commands)
" n           normal
" o           operator-pending
" s           select
" v           visual and select
" x           visual

" Save with sudo
cmap w!! w !sudo tee % >/dev/null

" Easy vimrc management
map <leader>rc :e $HOME/.vimrc<cr>  " edit .vimrc
map <leader>vrc :vsp $HOME/.vimrc<cr>  " open .vimrc in a split window
map <leader>source :w<cr> :source $HOME/.vimrc<cr> " save and reload .vimrc

" YAML traversal
map <leader>yg :YamlGoToKey
map <leader>yp :YamlGetFullPath<CR>
map <leader>yu :YamlGoToParent<CR>

" Toggle NERDTree
map <leader>nerd :NERDTreeToggle<CR>

" Turn off search highlighting more easily
nmap <silent> <leader>/ :nohlsearch<CR>

" Toggle Git Gutter
nmap <leader>ggt :GitGutterToggle<CR>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Switch to last file
nnoremap <leader><leader> <c-^>

" Yank path of current file
nnoremap <silent> <leader>yfp :let @+=expand("%")<CR>

" Code review shortcuts for screen
nnoremap <leader>df :call <SID>DiffFile()<CR>
nnoremap <leader>of :call <SID>OpenFile()<CR>
nnoremap <leader>rf :call <SID>ReviewFile()<CR>

" Open TODO topic heading
nnoremap <leader>th O<ESC>80i-<ESC>o<ESC>78i`<ESC>O

" Toggle paste
nnoremap <leader>paste :set invpaste paste?<CR>

" Toggle relative line numbers
nnoremap <leader>rnu :set invrnu<CR>

" Strip trailing whitespace
nnoremap <leader>rstrip :call <SID>StripTrailingWhitespaces()<CR>

" Toggle line wrapping
nnoremap <leader>wrap :set wrap!<CR>

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

"
""
""" }}}

""" Functions {{{
""
"

function! <SID>DiffFile()
  :silent !tmux send-keys -t levelup:0.0 'git diff master...head <cfile>'
  :redraw!
endfunction

function! <SID>OpenFile()
  :silent !tmux send-keys -t levelup:1.0 'vim <cfile>'
  :redraw!
endfunction

function! <SID>ReviewFile()
  :call <SID>DiffFile()
  :call <SID>OpenFile()
endfunction

" Split lines in range on `pattern`
function! SplitLine(pattern) range
  " Concatenates to something like :10,35s/\s*,\s*/\r/g
  execute ':' . a:firstline . ',' . a:lastline . 's/\s*' . a:pattern . '\s*/\r/g'
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

"
""
""" }}}

""" Commands {{{
""
"

" Use `:Split ,` to split comma-separated items onto their own lines
" The `-range` option enables using `:Split` with visual selections
" <line1> is the first line of the range, <line2> is the last line of the range
command -nargs=1 -range Split <line1>,<line2>call SplitLine(<f-args>)

"
""
""" }}}

""" Auto Commands {{{
""
"

if has("autocmd")
  " Whitespace preferences
  autocmd FileType conf setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType GO setlocal ts=2 sts=2 sw=2 expandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " Treat RABL files as Ruby
  autocmd Bufenter *.rabl setfiletype ruby
endif

"
""
""" }}}

" vim:foldmethod=marker:foldlevel=0
