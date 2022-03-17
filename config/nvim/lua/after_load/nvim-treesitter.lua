require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'css',
    'dockerfile',
    'eex',
    'elixir',
    'erlang',
    'go',
    'html',
    'javascript',
    'json',
    'markdown',
    'ruby',
    'scss',
    'vim',
    'yaml'
  },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = false,
    disable = {}, -- disabled for these languages
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
  indent = { enable = true },
  matchup = {
    enable = true,
    disable = {}, -- disabled for these languages
  },
})
