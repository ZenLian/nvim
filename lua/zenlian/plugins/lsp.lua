local func = require('vim.func')
return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim', config = function() end },
    },
    opts_extend = {
      'ensure_installed',
    },
    -- this is not actually opts of lspconfig, it's our own opts
    -- override by every lang
    opts = {
      -- @type string[]
      -- preinstalled lsp
      ensure_installed = {
        -- "lua_ls",
      },
      servers = {
        -- lua_ls = {
        -- -- @type LazyKeySpec[]
        -- -- extra keymaps
        --   keys = {},
        -- -- custom capabilities
        --   capabilities = {},
        -- },
      },
    },
    config = function(_, opts)
      -- TODO: deprecated
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      local function setup(server)
        local server_opts = opts.servers[server] or {}
        local keys = vim.deepcopy(server_opts.keys)
        server_opts.keys = nil
        -- setup on_attach callback
        server_opts.on_attach = function(client, bufnr)
          require('zenlian.plugins.lsp.keymaps').on_attach(client, bufnr, keys)
        end
        server_opts.capabilities = require('blink.cmp').get_lsp_capabilities(server_opts.capabilities)
        require('lspconfig')[server].setup(server_opts)
      end

      require('mason-lspconfig').setup {
        ensure_installed = opts.ensure_installed,
        automatic_installation = nil,
        handlers = { setup },
      }
    end,
  },

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    -- build = ":MasonUpdate",
    opts_extend = { 'ensure_installed' },
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '󰄬',
          package_pending = '󰑓',
          package_uninstalled = '●',
        },
      },
    },
  },
}
