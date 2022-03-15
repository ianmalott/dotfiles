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

" Use space for <leader>, leaving default \ as <leader>
map <space> <leader>

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

" Save with sudo
cmap w!! w !sudo tee % >/dev/null

" Turn off search highlighting more easily
nmap <silent> <leader>/ :nohlsearch<CR>

" Toggle Git Gutter
nmap <leader>ggt :GitGutterToggle<CR>

" Find files using Telescope command-line sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Switch to last file
nnoremap <leader><leader> <c-^>

" Yank file path of current buffer
nnoremap <silent> <leader>yfp :let @+=expand("%")<CR>

" Open TODO topic heading
nnoremap <leader>th O<ESC>80i-<ESC>o<ESC>78i`<ESC>O

" Toggle paste
nnoremap <leader>paste :set invpaste paste?<CR>

" Toggle relative line numbers
nnoremap <leader>rnu :set invrnu<CR>

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
