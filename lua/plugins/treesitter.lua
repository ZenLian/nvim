local config = function()
  require('nvim-treesitter.configs').setup {
    -- ensure_installed = {
    --   'bash',
    --   'c',
    --   'cmake',
    --   'cpp',
    --   'css',
    --   'dockerfile',
    --   'go',
    --   -- 'help',
    --   'html',
    --   'javascript',
    --   'json',
    --   'json5',
    --   -- 'jsonc',
    --   'latex',
    --   'lua',
    --   'markdown',
    --   'python',
    --   'query',
    --   'regex',
    --   'scss',
    --   'toml',
    --   'typescript',
    --   'vim',
    --   'yaml',
    -- },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'vn',
        node_incremental = '+',
        node_decremental = '-',
        -- scope_incremental = '',
      },
    },
    -- textobjects = {
    --   select = {
    --     enable = true,
    --     lookahead = true,
    --     keymaps = {
    --       ['af'] = '@function.outer',
    --       ['if'] = '@function.inner',
    --       ['ac'] = '@class.outer',
    --       ['ic'] = '@class.inner',
    --       ['aa'] = '@parameter.outer',
    --       ['ia'] = '@parameter.inner',
    --       ['ab'] = '@block.outer',
    --       ['ib'] = '@block.inner',
    --     },
    --   },
    --   move = {
    --     enable = true,
    --     set_jumps = true, -- whether to set jumps in the jumplist
    --     goto_next_start = {
    --       [']['] = '@function.outer',
    --       [']c'] = '@class.outer',
    --       [']a'] = '@parameter.inner',
    --     },
    --     goto_next_end = {
    --       [']]'] = '@function.outer',
    --       [']C'] = '@class.outer',
    --     },
    --     goto_previous_start = {
    --       ['[['] = '@function.outer',
    --       ['[c'] = '@class.outer',
    --       ['[a'] = '@parameter.inner',
    --     },
    --     goto_previous_end = {
    --       ['[]'] = '@function.outer',
    --       ['[C'] = '@class.outer',
    --     },
    --   },
    --   swap = {
    --     enable = false,
    --   },
    --   lsp_interop = {
    --     enable = true,
    --     peek_definition_code = {
    --       ['gD'] = '@function.outer',
    --     },
    --   },
    -- },
    rainbow = {
      enable = true,
      disable = { 'html' }, -- list of languages you want to disable the plugin for
      extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    },
  }
end

return {
  config = config,
}
