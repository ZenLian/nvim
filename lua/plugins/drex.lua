local M = {}

function M.config()
  local elements = require('drex.elements')
  local utils = require('drex.utils')
  local files = require('drex.actions.files')

  require('drex.config').configure {
    hide_cursor = false,
    -- hijack_netrw = true,
    drawer = {
      default_width = 30,
      window_picker = {
        enabled = true,
        labels = 'jklhfdsgamiounewrcvtybxz',
      },
    },
    keybindings = {
      ['n'] = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['~'] = '<cmd>Drex ~<cr>',
        ['<BS>'] = '<cmd>lua require("drex.elements").open_parent_directory()<cr>',
        ['.'] = '<cmd>lua require("drex.elements").open_directory()<cr>',
        ['<CR>'] = function()
          local line = vim.api.nvim_get_current_line()

          if require('drex.utils').is_open_directory(line) then
            elements.collapse_directory()
          else
            elements.expand_element()
          end
        end,
        -- create inside
        ['a'] = function()
          local line = vim.api.nvim_get_current_line()
          if utils.is_directory(line) then
            files.create(utils.get_element(line) .. utils.path_separator)
          else
            -- fallback to same level if element is not a directory
            files.create(utils.get_path(line))
          end
        end,
        -- create at same level
        ['A'] = function()
          local line = vim.api.nvim_get_current_line()
          files.create(utils.get_path(line))
        end,
        -- expand every directory in the current buffer
        ['zr'] = function()
          local row = 1
          while true do
            local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
            if utils.is_closed_directory(line) then
              elements.expand_element(0, row)
            end
            row = row + 1

            if row > vim.fn.line('$') then
              break
            end
          end
        end,
        -- collapse every directory in the current buffer
        ['zm'] = function()
          local row = 1
          while true do
            local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
            if utils.is_open_directory(line) then
              elements.collapse_directory(0, row)
            end
            row = row + 1

            if row > vim.fn.line('$') then
              break
            end
          end
        end,
      },
    },
    on_enter = function()
      vim.opt_local.buflisted = false
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.winhighlight = 'Normal:NeoTreeNormal,NormalNC:NeoTreeNormal'
    end,
  }
  --> https://github.com/TheBlob42/drex.nvim/wiki/Configuration#only-drex-buffers-for-the-drawer
  vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('DrexDrawerWindow', {}),
    pattern = '*',
    callback = function(args)
      if vim.api.nvim_get_current_win() == require('drex.drawer').get_drawer_window() then
        local is_drex_buffer = function(b)
          local ok, syntax = pcall(vim.api.nvim_buf_get_option, b, 'syntax')
          return ok and syntax == 'drex'
        end
        local prev_buf = vim.fn.bufnr('#')

        if is_drex_buffer(prev_buf) and not is_drex_buffer(args.buf) then
          vim.api.nvim_set_current_buf(prev_buf)
          vim.schedule(function()
            vim.cmd([['"]]) -- restore former cursor position
          end)
        end
      end
    end,
  })
end

return M
