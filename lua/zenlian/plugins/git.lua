---@type LazyPluginSpec[]
return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      on_attach = function(buffer)
        local gitsigns = require('gitsigns')

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buffer })
        end

        -- same as vimdiff `:h jumpto-diffs`
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk('prev')
          end
        end, 'Previous Hunk')
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk('next')
          end
        end, 'Next Hunk')
        map({ 'n', 'v' }, '<leader>ghs', gitsigns.stage_hunk, '(Un)Stage Hunk')
        map({ 'n', 'v' }, '<leader>ghr', gitsigns.reset_hunk, 'Reset Hunk')
        map('n', '<leader>ghp', gitsigns.preview_hunk_inline, 'Stage Buffer')
        map('n', '<leader>ghS', gitsigns.stage_buffer, 'Stage Buffer')
        map('n', '<leader>ghR', gitsigns.reset_buffer, 'Reset Buffer')
        map('n', '<leader>gb', function()
          gitsigns.blame_line { full = true }
        end, 'Blame Line')
        map('n', '<leader>gB', gitsigns.blame, 'Blame Buffer')
        -- map('n', '<leader>gd', gitsigns.diffthis, 'Diffthis')
        -- map('n', '<leader>gD', function()
        --   gitsigns.diffthis('~')
        -- end, 'Diffthis~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git Hunk')
        map({ 'o', 'x' }, 'ah', ':<C-U>Gitsigns select_hunk<CR>', 'Git Hunk')
      end,
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      Snacks.toggle({
        id = 'git_signs',
        name = 'Git Signs',
        get = function()
          return require('gitsigns.config').config.signcolumn
        end,
        set = function(state)
          require('gitsigns').toggle_signs(state)
        end,
      }):map('<leader>\\g')
    end,
  },

  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diff View' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Close Diff View' },
    },
    opts = {
      keymaps = {
        view = {
          ['q'] = '<cmd>DiffviewClose<cr>',
        },
        file_panel = {
          ['q'] = '<cmd>DiffviewClose<cr>',
        },
        file_history_panel = {
          ['q'] = '<cmd>DiffviewClose<cr>',
        },
      },
    },
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' },
    },
    opts = {
      disable_commit_confirmation = true,
      signs = {
        section = { '', '' },
        item = { '', '' },
        hunk = { '', '' },
      },
    },
  },
}
