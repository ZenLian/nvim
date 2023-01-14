local spec = {
  'ziontee113/syntax-tree-surfer',
  dependencies = 'nvim-treesitter',
  keys = {
    { 'vU' },
    { 'vD' },
    { 'vu' },
    { 'vd' },
    { 'vx' },
    { 'vn' },
    { 'J', mode = 'x' },
    { 'K', mode = 'x' },
    { 'H', mode = 'x' },
    { 'L', mode = 'x' },
    { '<A-u>', mode = 'x' },
    { '<A-d>', mode = 'x' },
  },
}

spec.config = function()
  require('syntax-tree-surfer').setup {}
  -- Syntax Tree Surfer
  local opts = { noremap = true, silent = true }

  -- Normal Mode Swapping:
  -- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
  vim.keymap.set('n', 'vU', function()
    vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true, desc = 'Swap Parent Up' })
  vim.keymap.set('n', 'vD', function()
    vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true, desc = 'Swap Parent Down' })

  -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
  vim.keymap.set('n', 'vd', function()
    vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true, desc = 'Swap with Next' })
  vim.keymap.set('n', 'vu', function()
    vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
    return 'g@l'
  end, { silent = true, expr = true, desc = 'Swap with Prev' })

  --> If the mappings above don't work, use these instead (no dot repeatable)
  -- vim.keymap.set("n", "vd", '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
  -- vim.keymap.set("n", "vu", '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
  -- vim.keymap.set("n", "vD", '<cmd>STSSwapDownNormal<cr>', opts)
  -- vim.keymap.set("n", "vU", '<cmd>STSSwapUpNormal<cr>', opts)

  -- Swapping Nodes in Visual Mode
  vim.keymap.set('x', '<A-u>', '<cmd>STSSwapNextVisual<cr>', { silent = true, desc = 'Swap Prev' })
  vim.keymap.set('x', '<A-d>', '<cmd>STSSwapPrevVisual<cr>', { silent = true, desc = 'Swap Next' })

  -- Visual Selection from Normal Mode
  vim.keymap.set('n', 'vp', '<cmd>STSSelectMasterNode<cr>', { silent = true, desc = 'Select Parent Node' })
  vim.keymap.set('n', 'vn', '<cmd>STSSelectCurrentNode<cr>', { silent = true, desc = 'Select Current Node' })

  -- Select Nodes in Visual Mode
  vim.keymap.set('x', 'J', '<cmd>STSSelectNextSiblingNode<cr>', opts)
  vim.keymap.set('x', 'K', '<cmd>STSSelectPrevSiblingNode<cr>', opts)
  vim.keymap.set('x', 'H', '<cmd>STSSelectParentNode<cr>', opts)
  vim.keymap.set('x', 'L', '<cmd>STSSelectChildNode<cr>', opts)
end

return { spec }
