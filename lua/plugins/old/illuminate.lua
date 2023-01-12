local config = function()
  -- https://github.com/RRethy/vim-illuminate#configuration
  -- default configuration
  require('illuminate').configure {
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
      'checkhealth',
      'qf',
      'dirvish',
      'fugitive',
      'packer',
      'mason',
      'null-ls-info',
      'NvimTree',
      'neo-tree',
      'drex',
      'TelescopePrompt',
      'DressingInput',
      'alpha',
      'aerial',
      'NeogitStatus',
      'NeogitPopup',
    },
    -- modes_denylist = { 'v', 'V' },
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    modes_allowlist = { 'n' },
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
  }
end

return {
  packer = {
    config = config,
  },
}
