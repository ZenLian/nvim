return {
  {
    "neovim/nvim-lspconfig",
    event = {"BufReadPost", "BufNewFile", "BufWritePre"},
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts_extend = {
      "ensure_installed",
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
        -- }
      }
    },
    config = function (_, opts)
      -- ui related
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      local function on_attach(client, bufnr)
        require('zenlian.plugins.lsp.keymaps').on_attach(client, bufnr)
      end
      local function setup(server)
        local server_opts = opts.servers[server] or {}
        server_opts.on_attach = on_attach
        server_opts.capabilities = require('blink.cmp').get_lsp_capabilities(server_opts.capabilities)
        require('lspconfig')[server].setup(server_opts)
      end

      require("mason-lspconfig").setup {
        ensure_installed = opts.ensure_installed,
        handlers = { setup }
      }
    end
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    -- build = ":MasonUpdate",
    opts_extend = { 'ensure_installed', },
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = "󰄬",
          package_pending = "󰑓",
          package_uninstalled = "●"
        }
      },
    },
  }
}
