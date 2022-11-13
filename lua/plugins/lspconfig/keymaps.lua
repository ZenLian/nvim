local M = {}

local wk = require('which-key')

local leader = {
  s = {
    d = { '<cmd>Telescope diagnostics<cr>', 'Search Diagnostics' },
  },
  l = {
    name = 'language',
    f = {
      function()
        require('plugins.lspconfig.formatting').format()
      end,
      'File format',
    },
    a = { vim.lsp.buf.code_action, 'Code action' },
    r = { vim.lsp.buf.rename, 'Rename' },
    d = { vim.diagnostic.open_float, 'Line Diagnostics' },
  },
}

local leader_visual = {
  l = {
    name = 'language',
    f = {
      function()
        require('plugins.lspconfig.formatting').format {
          range = {},
        }
      end,
      'Range Format',
    },
    a = { vim.lsp.buf.range_code_action, 'Code action' },
  },
}

local g = {
  name = '+goto',
  r = { '<cmd>Telescope lsp_references<cr>', 'References' },
  R = { '<cmd>Trouble lsp_references<cr>', 'Trouble References' },
  d = { '<Cmd>Telescope lsp_definitions <CR>', 'Goto Definition' },
  -- D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
  D = { 'Peek Definition' }, -- by treesitter
  -- s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
  I = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Goto Implementation' },
  t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Goto Type Definition' },
}

local misc = {
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
  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>')
  map('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>')

  wk.register(leader, { buffer = bufnr, prefix = '<Leader>' })
  wk.register(leader_visual, { buffer = bufnr, prefix = '<Leader>', mode = 'v' })
  wk.register(g, { buffer = bufnr, prefix = 'g' })
  wk.register(misc, { buffer = bufnr })
end

return M
