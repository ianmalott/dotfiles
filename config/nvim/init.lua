------ Plugins {{{
----
--

require('plugins')

--
----
------ }}}

------ Abbreviations {{{
----
--

vim.cmd('source ./legacy/abbreviations.vim')

--
----
------ }}}

------ Colors {{{
----
--

vim.cmd('source ./legacy/colors.vim')

--
----
------ }}}

------ Variables {{{
----
--

vim.g.gitgutter_enabled = 0 -- disabled by default (toggle with <leader>ggt)
vim.g.lightline = { colorscheme = 'embark' } -- use solarized colors for lightline
vim.g.rails_ctags_arguments = '--exclude=tmp --exclude=vendor'
vim.g.ruby_indent_hanging_elements = 0 -- vim-ruby setting

--
----
------ }}}

------ Options {{{
----
--

vim.opt.backup = false
vim.opt.cindent = false -- c-style indenting
vim.opt.clipboard = 'unnamed' -- enable clipboard integration with Mac OS X
vim.opt.cursorline = true -- highlight current line
vim.opt.expandtab = true -- replace tabs with spaces
vim.opt.fileformat = 'unix' -- use the unix fileformat
vim.opt.foldmethod = 'marker' -- use default {{{ fold this }}} markers
vim.opt.ignorecase = true -- case insensitive search; see smartcase below
vim.opt.magic = true -- use default escaping in search patterns (use /\vpattern for verymagic)
vim.opt.number = true -- show absolute line number of current line
vim.opt.numberwidth = 2 -- characters allotted for line numbers
vim.opt.paste = false -- abbreviations don't work when paste mode is on
vim.opt.pastetoggle = '<leader>paste' -- specify key sequence for toggling 'paste' option
vim.opt.relativenumber = true -- use relative line numbers
vim.opt.ruler = false -- show the cursor position: (line, column)
vim.opt.shiftround = true -- round indent to multiple of 'shiftwidth'
vim.opt.shiftwidth = 2 -- number of spaces used with (auto)indention
vim.opt.showmatch = true -- flash matching () {} []
vim.opt.showmode = true -- display current mode
vim.opt.smartcase = true -- case insensitive except with initial capital
vim.opt.smartindent = false -- use autoindent instead
vim.opt.softtabstop = 2
vim.opt.splitbelow = true -- open horizontal splits below instead of above
vim.opt.splitright = true -- open vertical splits to the right instead of to the left
vim.opt.swapfile = false
vim.opt.tabstop = 2 -- tab size
vim.opt.termguicolors = true -- required for embark color scheme
vim.opt.updatetime = 250 -- write to swap after 250ms idle (default: 4000ms)
vim.opt.visualbell = false -- don't blink the screen when there is an error
vim.opt.wildmode = 'list:longest' -- tab completion up to point of ambiguity

--
----
------ }}}

------ Mappings {{{
----
--

vim.cmd('source ./legacy/mappings.vim')

--
----
------ }}}


-- vim:foldmethod=marker:foldlevel=0
