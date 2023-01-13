local M = {}

local util = require('util')

local illuminate = {
  ['<A-n>'] = {
    function()
      require('illuminate').next_reference { wrap = true }
    end,
    'Next reference',
  },
  ['<A-p>'] = {
    function()
      require('illuminate').next_reference { reverse = true, wrap = true }
    end,
    'Previous reference',
  },
}

function M.on_attach(_, bufnr)
  util.keymaps({
    ['[d'] = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', desc = 'Previous Diagnostic' },
    [']d'] = { '<cmd>lua vim.diagnostic.goto_next()<CR>', desc = 'Next Diagnostic' },
    ['[e'] = {
      '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>',
      desc = 'Previous Error',
    },
    [']e'] = {
      '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>',
      desc = 'Next Error',
    },
    -- NOTE: 'K' overriden by ufo
    -- ['K'] = { '<cmd>lua vim.lsp.buf.hover()<cr>' },
    ['gd'] = { '<cmd>Telescope lsp_definitions<cr>', desc = 'Goto Definition' },
    ['gr'] = { '<cmd>Telescope lsp_references<cr>', desc = 'Goto References' },
    ['gR'] = { '<cmd>Trouble lsp_references<cr>', desc = 'Trouble References' },
    -- gD = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', desc = 'Goto Declaration' },
    -- gS = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', desc = 'Signature Help' },
    -- gI = { '<cmd>lua vim.lsp.buf.implementation()<CR>', desc = 'Goto Implementation' },
    -- gt = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', desc = 'Goto Type Definition' },
    ['<Leader>c'] = {
      ['f'] = {
        function()
          require('plugins.lspconfig.formatting').format()
        end,
        desc = 'File format',
      },
      ['a'] = { vim.lsp.buf.code_action, desc = 'Code action' },
      ['r'] = { vim.lsp.buf.rename, desc = 'Rename' },
      ['d'] = { vim.diagnostic.open_float, desc = 'Line Diagnostics' },
      ['D'] = { '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics' },
      -- ['D'] = { '<cmd>Telescope diagnostics<cr>', desc = 'Search Diagnostics' },
    },
  }, { buffer = bufnr })

  -- visual map
  util.keymaps({
    ['<Leader>lf'] = {
      function()
        require('plugins.lspconfig.formatting').format {
          range = {},
        }
      end,
      desc = 'Range Format',
    },
    ['<Leader>la'] = {
      vim.lsp.buf.range_code_action,
      desc = 'Code action',
    },
  }, { buffer = bufnr, mode = 'v' })
end

return M
