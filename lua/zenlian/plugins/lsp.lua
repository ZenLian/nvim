---@type LazyPluginSpec[]
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
    ---@type vim.diagnostic.Opts
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          source = 'if_many',
          spacing = 4,
          prefix = '●',
        },
        signs = {
          -- text = {},
        },
      },
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
      local icons = require('zenlian.config').icons.diagnostics
      local signs = {
        [vim.diagnostic.severity.ERROR] = icons.Error,
        [vim.diagnostic.severity.WARN] = icons.Warn,
        [vim.diagnostic.severity.INFO] = icons.Info,
        [vim.diagnostic.severity.HINT] = icons.Hint,
      }
      opts.diagnostics.signs.text = signs
      ---@param diagnostic vim.Diagnostic
      opts.diagnostics.virtual_text.prefix = function(diagnostic)
        return signs[diagnostic.severity]
      end
      vim.diagnostic.config(opts.diagnostics)

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
