local M = {}

local util = require('util')

local leader = {
  s = {
    { 'd', '<cmd>Telescope diagnostics<cr>', 'Search Diagnostics' },
  },
  l = {
    {
      'f',
      function()
        require('plugins.lspconfig.formatting').format()
      end,
      'File format',
    },
    { 'a', vim.lsp.buf.code_action, 'Code action' },
    { 'r', vim.lsp.buf.rename, 'Rename' },
    { 'd', vim.diagnostic.open_float, 'Line Diagnostics' },
    { 'D', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace Diagnostics' },
  },
}

local leader_visual = {
  l = {
    {
      'f',
      function()
        require('plugins.lspconfig.formatting').format {
          range = {},
        }
      end,
      'Range Format',
    },
    { 'a', vim.lsp.buf.range_code_action, 'Code action' },
  },
}

local g = {
  r = { '<cmd>Telescope lsp_references<cr>', 'Goto References' },
  R = { '<cmd>Trouble lsp_references<cr>', 'Trouble References' },
  d = { '<Cmd>Telescope lsp_definitions <CR>', 'Goto Definition' },
  -- D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
  -- D = { 'Peek Definition' }, -- by treesitter
  -- S = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
  -- I = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Goto Implementation' },
  -- t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Goto Type Definition' },
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
  -- map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>')
  map('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>')
  -- util.keymaps({
  --   n = {
  --     { '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
  --     { ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>' },
  --     { '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>' },
  --     { ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>' },
  --   },
  -- }, { buffer = bufnr })

  -- util.keymaps({ ['n'] = { ['<Leader>'] = leader } }, { buffer = bufnr })
  -- util.keymaps({ ['v'] = { ['<Leader>'] = leader_visual } }, { buffer = bufnr })
  -- util.keymaps({ ['n'] = { g = g } }, { buffer = bufnr })
  -- util.keymaps({ ['n'] = misc }, { buffer = bufnr })
end

return M
