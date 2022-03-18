local lsp_installer = require("nvim-lsp-installer")

--
-- Ensure certain language servers are always installed
--

local servers = {
  "bashls",
  "elixirls",
  "solargraph", -- ruby LS
  "yamlls",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)

  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

--
-- Specify mappings (no defaults set by nvim-lspconfig)
--

local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Default options
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

--
-- Customize LSP server options
--

local custom_server_options = {
  ["elixirls"] = function (options)
    options.settings = {
      elixirLS = {
        dialyzerFormat = 'dialyzer'
      }
    }
  end,
  ["eslintls"] = function (options)
    options.settings = {
      format = {
        enable = true,
      },
    }
  end,
}

--
-- Set up each server with mappings and custom options (specified above)
--

lsp_installer.on_server_ready(function (server)
  -- Default options for all servers
  local options = {
    on_attach = on_attach,
  }

  -- Override default options with server-specific ones
  if custom_server_options[server.name] then
    custom_server_options[server.name](options)
  end

  server:setup(options)
end)
