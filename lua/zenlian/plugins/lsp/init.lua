return {
  {
    "neovim/nvim-lspconfig",
    event = {"BufReadPost", "BufNewFile", "BufWritePre"},
    enabled = true,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    -- this is not actually opts of lspconfig, it's our own opts
    -- override by every lang
    opts = {
      ensure_installed = {
        "lua_ls",
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          }
        }
      }
    },
    config = function (_, opts)
      local function setup(server)
        local server_opts = opts.servers[server] or {}
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
    opts = {},
  }
}