local M = {}

M.config = function()
  local conditions = require('heirline.conditions')
  local utils = require('heirline.utils')

  local palette = require('catppuccin.palettes').get_palette()
  local colors = {
    bg = palette.base,
    fg = palette.text,
    red = palette.red,
    green = palette.green,
    yellow = palette.yellow,
    blue = palette.blue,
    magenta = palette.peach,
    cyan = palette.teal,
  }
  require('heirline').load_colors(colors)

  local Align = { provider = '%=' }
  local Space = { provider = ' ' }

  local ViMode = {
    provider = '█ ',
    hl = function(self)
      return { fg = self:mode_color() }
    end,
    update = { 'ModeChanged' },
  }

  local SquareMode = {
    provider = '█',
    hl = function(self)
      return { fg = self:mode_color() }
    end,
    update = { 'ModeChanged' },
  }

  local FileFlags = {
    {
      condition = function()
        return vim.bo.modified
      end,
      provider = '[+]',
      hl = { fg = 'green' },
    },
    {
      condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = ' ',
      hl = { fg = 'red' },
    },
  }

  local FileIcon = {
    init = function(self)
      local filename = self.filename or vim.api.nvim_buf_get_name(0)
      local extension = vim.fn.fnamemodify(filename, ':e')
      self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
      return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local FileName = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
    FileIcon,
    -- filename
    {
      provider = function(self)
        if vim.bo.filetype == 'help' then
          return vim.fn.fnamemodify(self.filename, ':t')
        end
        -- first, trim the pattern relative to the current directory.
        -- :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ':.')
        if filename == '' then
          return '[No Name]'
        end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      hl = { fg = 'blue' },
    },
    FileFlags,
    { provider = '%<' }, -- this means that the statusline is cut here when there's not enough space
  }

  local WorkDir = {
    provider = function()
      -- local icon = (vim.fn.haslocaldir(0) == 1 and 'l' or 'g') .. ' ' .. ' '
      local cwd = vim.fn.getcwd(0)
      cwd = vim.fn.fnamemodify(cwd, ':~')
      -- if not conditions.width_percent_below(#cwd, 0.25) then
      --   cwd = vim.fn.pathshorten(cwd)
      -- end
      local trail = cwd:sub(-1) == '/' and '' or '/'
      return cwd .. trail
    end,
    hl = { fg = 'blue', bold = true },
  }

  local HelpFileName = {
    condition = function()
      return vim.bo.filetype == 'help'
    end,
    provider = function(self)
      vim.fn.bufname(0)
      local filename = vim.api.nvim_buf_get_name(0)
      return vim.fn.fnamemodify(filename, ':t')
    end,
    hl = { fg = 'blue' },
  }

  local FileType = {
    provider = function()
      return vim.bo.filetype
    end,
    hl = { fg = 'yellow' },
  }
  local FileEncoding = {
    provider = function()
      local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return enc ~= 'utf-8' and enc:upper() .. ' '
    end,
  }
  local FileFormat = {
    provider = function()
      local fmt = vim.bo.fileformat
      return fmt ~= 'unix' and fmt:upper() .. ' '
    end,
  }
  local FileSize = {
    provider = function()
      -- stackoverflow, compute human readable file size
      local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
      local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
      fsize = (fsize < 0 and 0) or fsize
      if fsize < 1024 then
        return fsize .. suffix[1]
      end
      local i = math.floor((math.log(fsize) / math.log(1024)))
      return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
    end,
  }

  local FileInfo = {
    FileEncoding,
    FileFormat,
    FileType,
  }

  local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    provider = '%7(%l/%-3L%):%-2c',
  }

  local ScrollBar = {
    static = {
      -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
      -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
      sbar = { '▇', '▆', '▅', '▄', '▃', '▂', '▁', ' ' },
    },
    provider = function(self)
      local curr_line = vim.api.nvim_win_get_cursor(0)[1]
      local lines = vim.api.nvim_buf_line_count(0)
      local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
      return self.sbar[i]
    end,
    hl = function(self)
      return { fg = 'bg', bg = self:mode_color() }
    end,
    update = { 'CursorMoved', 'CursorMovedI', 'ModeChanged' },
  }

  local LSPActive = {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },

    provider = function()
      local names = vim.tbl_map(function(client)
        return client.name
      end, vim.lsp.get_active_clients { bufnr = 0 })
      return '[' .. table.concat(names, ' ') .. ']'
    end,
    hl = { fg = 'green', bold = true },
  }

  local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
      signs = require('plugins.lspconfig.diagnostic').signs,
    },

    init = function(self)
      for severity, _ in pairs(self.signs) do
        self[severity] = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[string.upper(severity)] })
      end
    end,

    update = { 'DiagnosticChanged', 'BufEnter' },
  }

  for severity, icon in pairs(Diagnostics.static.signs) do
    table.insert(Diagnostics, {
      provider = function()
        local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[string.upper(severity)] })
        return count > 0 and (icon .. ' ' .. count .. ' ')
      end,
      hl = { fg = utils.get_highlight('DiagnosticSign' .. severity).fg },
    })
  end

  local LspInfo = {
    Diagnostics,
    LSPActive,
  }

  local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = 'magenta' },

    { -- git branch name
      provider = function(self)
        return ' ' .. self.status_dict.head
      end,
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = '(',
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and ('+' .. count)
      end,
      hl = { fg = 'green' },
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and ('-' .. count)
      end,
      hl = { fg = 'red' },
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and ('~' .. count)
      end,
      hl = { fg = 'blue' },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = ')',
    },
  }

  local TerminalName = {
    -- we could add a condition to check that buftype == 'terminal'
    -- or we could do that later (see #conditional-statuslines below)
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', ''):gsub(';.*', '')
      return tname
    end,
    hl = { fg = 'blue', bold = true },
  }

  -- stylua: ignore
  local DefaultStatusline = {
    ViMode, Space, Git, Space, FileName, Align,
    LspInfo, Space, FileInfo, Space, Ruler, Space, ScrollBar,
  }

  local AlphaStatusline = {
    condition = function()
      return conditions.buffer_matches {
        filetype = { 'alpha', 'dashboard' },
      }
    end,
    static = {
      version = string.format(' NVIM v%s.%s.%s ', vim.version().major, vim.version().minor, vim.version().patch),
    },
    ViMode,
    Align,
    {
      provider = function(self)
        return self.version
      end,
    },
    Align,
    SquareMode,
  }

  local ExplorerStatusline = {
    condition = function()
      return vim.tbl_contains({ 'neo-tree', 'drex' }, vim.bo.filetype)
    end,
    SquareMode,
    {
      provider = '  ',
      hl = function(self)
        return { fg = self:mode_color() }
      end,
    },
    WorkDir,
    Align,
    FileType,
    Space,
    ScrollBar,
  }

  local QuickfixStatusline = {
    condition = function()
      return conditions.buffer_matches {
        buftype = { 'quickfix' },
        filetype = { 'qf', 'Trouble' },
      }
      -- return vim.tbl_contains({ 'qf', 'Trouble' }, vim.bo.filetype)
    end,
    static = {},
    {
      provider = '█ 🔨 ',
      hl = { fg = 'red' },
    },
    {
      provider = 'Quickfix',
      hl = { fg = 'magenta' },
    },
    Align,
    {
      provider = '█',
      hl = { fg = 'red' },
    },
  }

  local TerminalStatusline = {
    condition = function()
      return conditions.buffer_matches {
        buftype = { 'terminal' },
      }
    end,

    {
      provider = '█ ',
      hl = function(self)
        return { fg = self:mode_color() }
      end,
      update = { 'ModeChanged' },
    },
    Space,
    TerminalName,
    Align,
    {
      conditions = function()
        return conditions.buffer_matches {
          filetype = { 'toggleterm' },
        }
      end,
      provider = function()
        local trim = ''
        if vim.b.toggle_number then
          trim = '#' .. vim.b.toggle_number
        end
        return 'toggleterm' .. trim
      end,
      hl = { fg = 'yellow' },
    },
    Space,
    SquareMode,
  }


  -- stylua: ignore
  local SpecialStatusline = {
    condition = function()
      return conditions.buffer_matches {
        buftype = { 'nofile', 'prompt' },
        filetype = { '^git.*', 'fugitive', 'Neogit.*' },
        -- bufname = {'.*COMMIT_EDITMSG$'}
      }
    end,

    ViMode, Space, FileType, Align, SquareMode,
  }

  local StatusLines = {
    -- global stats
    static = {
      mode_names = {
        ['n'] = 'N',
        ['no'] = 'V',
        ['nov'] = 'V',
        ['noV'] = 'V',
        ['no'] = 'V',
        ['niI'] = 'N',
        ['niR'] = 'N',
        ['niV'] = 'N',
        ['nt'] = 'N',
        ['v'] = 'V',
        ['vs'] = 'V',
        ['V'] = 'V',
        ['Vs'] = 'V',
        [''] = 'V',
        ['s'] = 'V',
        ['s'] = 'V',
        ['S'] = 'V',
        [''] = 'V',
        ['i'] = 'I',
        ['ic'] = 'I',
        ['ix'] = 'I',
        ['R'] = 'R',
        ['Rc'] = 'R',
        ['Rx'] = 'N',
        ['Rv'] = 'N',
        ['Rvc'] = 'R',
        ['Rvx'] = 'R',
        ['c'] = 'C',
        ['cv'] = 'C',
        ['r'] = 'R',
        ['rm'] = 'N',
        ['r?'] = 'N',
        ['!'] = 'N',
        ['t'] = 'T',
      },
      mode_colors = {
        N = 'blue',
        I = 'green',
        V = 'yellow',
        R = 'yellow',
        C = 'magenta',
        T = 'green',
      },
      mode_color = function(self)
        local mode = conditions.is_active() and vim.fn.mode(1)
        return self.mode_colors[self.mode_names[mode] or 'N']
      end,
    },
    hl = { fg = 'fg', bg = 'bg' },
    fallthrough = false,
    AlphaStatusline,
    ExplorerStatusline,
    QuickfixStatusline,
    TerminalStatusline,
    SpecialStatusline,
    DefaultStatusline,
  }

  require('heirline').setup(StatusLines)
end

return M
