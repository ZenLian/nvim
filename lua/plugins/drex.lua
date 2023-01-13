local spec = {
  'theblob42/drex.nvim',
  cmd = { 'Drex', 'DrexDrawerOpen', 'DrexDrawerToggle' },
  keys = {
    { '<Leader>d', '<cmd>DrexDrawerToggle<CR>', desc = 'Toggle drex drawer' },
    { '<Leader>D', '<cmd>Drex<CR>', desc = 'Open drex buffer' },
  },
}

-- open multiple files, or a single file, if the clipboard is empty
function open_multiple(mode)
  local entries = require('drex.clipboard').get_clipboard_entries()
  local utils = require('drex.utils')

  local items = {}
  if mode == 'visual' then
    local startRow, endRow = utils.get_visual_selection()
    for row = startRow, endRow, 1 do
      table.insert(items, utils.get_element(vim.fn.getline(row)))
    end
  elseif #entries == 0 then
    items = { utils.get_element(vim.api.nvim_get_current_line()) }
  else
    items = entries
  end

  -- open multiple files
  vim.tbl_map(function(element)
    if not utils.is_directory(element) then
      vim.cmd('e ' .. element)
    end
  end, items)
end

spec.config = function()
  local elements = require('drex.elements')
  local utils = require('drex.utils')
  local files = require('drex.actions.files')

  local clear_clipboard_cmd = '<cmd>lua require("drex.clipboard").clear_clipboard()<CR>'

  require('drex.config').configure {
    icons = {
      dir_open = '',
      dir_closed = '',
    },
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
        ['<F5>'] = false,
        ['cc'] = false,
        ['cs'] = false,
        ['<C-r>'] = { '<cmd>lua require("drex").reload_directory()<CR>', { desc = 'reload' } },
        ['U'] = { clear_clipboard_cmd, { desc = 'clear clipboard' } },
        ['c'] = {
          '<cmd>lua require("drex.clipboard").open_clipboard_window()<CR>',
          { desc = 'edit clipboard' },
        },
        ['h'] = {
          '<cmd>lua require("plugins.drex").collapse()<cr>',
          { desc = 'collapse element' },
        },
        ['l'] = {
          '<cmd>lua require("plugins.drex").expand()<cr>',
          { desc = 'expand element' },
        },
        ['<CR>'] = {
          function()
            local line = vim.api.nvim_get_current_line()

            if utils.is_open_directory(line) then
              elements.collapse_directory()
            else
              elements.expand_element()
            end
          end,
          { desc = 'Open file or Toggle directory' },
        },
        ['<C-o>'] = {
          function()
            open_multiple()
          end,
          { desc = 'open elements' },
        },
        ['<TAB>'] = {
          function()
            local line = vim.api.nvim_get_current_line()
            if utils.is_closed_directory(line) then
              elements.expand_element()
            else
              elements.collapse_directory()
            end
          end,
          { desc = 'Toggle directory' },
        },
        ['~'] = {
          '<cmd>Drex ~<cr>',
          { desc = 'goto $HOME' },
        },
        ['-'] = {
          '<cmd>lua require("drex.elements").open_parent_directory()<cr>',
          { desc = 'open parent directory' },
        },
        ['.'] = {
          '<cmd>lua require("drex.elements").open_directory()<cr>',
          { desc = 'open child directory' },
        },
        ['a'] = {
          function()
            local line = vim.api.nvim_get_current_line()
            files.create(utils.get_path(line))
          end,
          { desc = 'Create' },
        },
        ['A'] = {
          function()
            local line = vim.api.nvim_get_current_line()
            if utils.is_directory(line) then
              files.create(utils.get_element(line) .. utils.path_separator)
            else
              -- fallback to same level if element is not a directory
              files.create(utils.get_path(line))
            end
          end,
          { desc = 'Create (inside) directory' },
        },
        ['d'] = {
          function()
            require('plugins.drex').flexible_action(require('drex.actions.files').delete)
          end,
          { desc = 'delete elements' },
        },
        ['r'] = {
          function()
            require('plugins.drex').flexible_action(require('drex.actions.files').multi_rename)
          end,
          { desc = 'rename elements' },
        },
        ['p'] = {
          '<cmd>lua require("drex.actions.files").copy_and_paste()<cr>' .. clear_clipboard_cmd,
          { desc = 'copy&paste(clipboard)' },
        },
        ['P'] = {
          '<cmd>lua require("drex.actions.files").cut_and_move()<cr>' .. clear_clipboard_cmd,
          { desc = 'cut&move(clipboard)' },
        },
        -- TODO: trash visual/clipboard
        ['t'] = {
          function()
            local line = vim.api.nvim_get_current_line()
            local element = require('drex.utils').get_element(line)
            vim.fn.jobstart("trash-put '" .. element .. "' &", { detach = true })
          end,
          { desc = 'trash elements' },
        },
        ['X'] = {
          function()
            local line = vim.api.nvim_get_current_line()
            local element = require('drex.utils').get_element(line)
            vim.fn.jobstart("${OPENER:-xdg-open} '" .. element .. "' &", { detach = true })
          end,
          { desc = 'open with system opener' },
        },
        ['zr'] = {
          function()
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
          { desc = 'expand all' },
        },
        ['zm'] = {
          function()
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
          { desc = 'collapse all' },
        },
      },
      ['v'] = {
        ['<CR>'] = {
          -- '<cmd>lua require("plugins.drex").open_multiple("visual")<cr>',
          function()
            open_multiple('visual')
          end,
          { desc = 'open files' },
        },
        ['<C-o>'] = {
          -- '<cmd>lua require("plugins.drex").open_multiple("visual")<cr>',
          function()
            open_multiple('visual')
          end,
          { desc = 'open files' },
        },
      },
    },
    on_enter = function()
      vim.opt_local.buflisted = false
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.winhighlight = 'Normal:NeoTreeNormal,NormalNC:NeoTreeNormal'
    end,
    on_leave = function()
      require('drex.clipboard').clear_clipboard()
    end,
  }

  -- TODO: open in nearest window, like what neo-tree did
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

-- Auto expand sub-directories if their only child is a single directory for quicker navigation
-- > https://github.com/TheBlob42/drex.nvim/wiki/Custom-Actions#auto-expand
function expand()
  local elements = require('drex.elements')
  local utils = require('drex.utils')
  -- local start = vim.api.nvim_win_get_cursor(0) -- OPTIONAL

  while true do
    elements.expand_element()

    local row = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(0, row - 1, row + 2, false)

    -- special case for files
    if lines[1] and not utils.is_directory(lines[1]) then
      return
    end

    -- check if a given line is a child element of the expanded element
    local is_child = function(l)
      if not l then
        return false
      end
      return vim.startswith(utils.get_element(l), utils.get_element(lines[1]) .. utils.path_separator)
    end

    if is_child(lines[2]) and utils.is_directory(lines[2]) and not is_child(lines[3]) then
      vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
    else
      -- vim.api.nvim_win_set_cursor(0, start) -- OPTIONAL
      return
    end
  end
end

-- wrapper of collapse_directory without warning when collapsing root path!
function collapse()
  local utils = require('drex.utils')
  local buffer = vim.api.nvim_get_current_buf() -- defaults to current buffer
  local line = vim.api.nvim_get_current_line()
  local path
  if utils.is_open_directory(line) then
    path = utils.get_element(line) .. utils.path_separator
  else
    path = utils.get_path(line)
  end
  if path == utils.get_root_path(buffer) then
    return
  end
  require('drex.elements').collapse_directory()
end

-- wrapper action to use "clipboard" if clipboard is not empty
function flexible_action(action)
  local entries = require('drex.clipboard').get_clipboard_entries()

  local mode = 'clipboard'
  if vim.tbl_isempty(entries) then
    mode = 'line'
  end

  action(mode)
end

return { spec }
