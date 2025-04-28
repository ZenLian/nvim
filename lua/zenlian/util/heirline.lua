local heirline = require('heirline')
local conditions = require('heirline.conditions')
local heir_utils = require('heirline.utils')
local Util = require('zenlian.util')
local Config = require('zenlian.config')

local M = {
  trim = function()
    return {
      provider = '%<',
    }
  end,
  align = function()
    return {
      provider = '%=',
    }
  end,
  space = function()
    return {
      provider = ' ',
    }
  end,
}

local mode_names = {
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
}

local mode_colors = {
  N = 'blue',
  I = 'green',
  V = 'purple',
  R = 'red',
  C = 'yellow',
  T = 'green',
}

local get_mode_name = function()
  local mode = vim.fn.mode(1)
  return mode_names[mode] or 'N'
end

local get_mode_color = function()
  return mode_colors[get_mode_name()]
end

function M.mode(provider)
  return {
    -- provider = provider or '█',
    provider = provider or ' ',
    hl = function()
      return { bg = get_mode_color() }
    end,
    update = { 'ModeChanged' },
  }
end

function M.root_dir(opts)
  opts = Util.tbl_extend({
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = '󱉭',
    color = 'fg',
  }, opts)
  local function get()
    local cwd = vim.uv.cwd() or ''
    local root = Util.root() or ''
    local name = vim.fs.basename(root)

    if root == cwd then
      -- root is cwd
      return opts.cwd and name
    elseif root:find(cwd, 1, true) then
      -- root is subdirectory of cwd
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) then
      -- root is parent directory of cwd
      return opts.parent and name
    else
      -- root and cwd are not related
      return opts.other and name
    end
  end

  return {
    provider = function()
      return ' ' .. (opts.icon and opts.icon .. ' ') .. get()
    end,
    condition = function()
      return type(get()) == 'string'
    end,
    hl = { fg = opts.color },
  }
end

function M.workdir(opts)
  opts = Util.tbl_extend({
    color = '',
  }, opts)

  return {
    provider = function()
      local cwd = vim.fn.getcwd(0)
      cwd = vim.fn.fnamemodify(cwd, ':~')
      return ' ' .. cwd
    end,
    hl = { fg = opts.color },
  }
end

function M.filetype(opts)
  opts = Util.tbl_extend({
    icon_only = false,
  }, opts)

  return {
    init = function(self)
      self.icon, self.icon_color =
        require('nvim-web-devicons').get_icon_color_by_filetype(vim.bo.filetype, { default = true })
    end,
    provider = function(self)
      local result = self.icon
      if not opts.icon_only then
        result = result .. ' ' .. vim.bo.filetype
      end
      return ' ' .. result
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }
end

function M.filepath(opts)
  opts = Util.tbl_extend({
    relative = 'cwd',
    modified_color = 'green',
  }, opts)

  return {
    init = function(self)
      self.path = vim.fn.expand('%:p') --[[@as string]]

      local root = Util.root() or ''
      local cwd = vim.uv.cwd() or ''
      if opts.relative == 'cwd' and self.path:find(cwd, 1, true) == 1 then
        self.path = self.path:sub(#cwd + 2)
      elseif opts.relative == 'root' and self.path:find(root, 1, true) == 1 then
        self.path = self.path:sub(#root + 2)
      end

      local parts = vim.split(self.path, '[\\/]')
      -- if #parts > 5 then
      --   parts = { parts[1], '…', parts[#parts - 1], parts[#parts] }
      -- end

      self.basename = parts[#parts]

      if #parts > 1 then
        parts[#parts] = nil
        self.pathname = table.concat(parts, '/')
      else
        self.pathname = nil
      end
    end,
    {
      condition = function(self)
        return self.pathname ~= nil
      end,
      provider = function(self)
        return self.pathname .. '/'
      end,
    },
    {
      provider = function(self)
        return self.basename
      end,
      hl = function()
        if vim.bo.modified then
          return { fg = opts.modified_color }
        else
          return {}
        end
      end,
    },
  }
end

function M.fileflags()
  return {
    {
      condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = '',
      hl = { fg = 'red' },
    },
    {
      condition = function()
        return vim.bo.modified
      end,
      provider = '●',
      hl = { fg = 'green' },
    },
  }
end

function M.git(opts)
  opts = Util.tbl_extend({
    color = 'purple',
  }, opts)

  return {
    condition = conditions.is_git_repo,
    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = { fg = opts.color },

    {
      provider = function(self)
        return '' .. self.status_dict.head
      end,
      on_click = {
        callback = function()
          vim.schedule(function()
            vim.cmd('FzfLua git_branches')
          end)
        end,
        name = 'heirline_gitbranch',
      },
    },
    {
      flexible = true,
      on_click = {
        callback = function()
          vim.schedule(function()
            require('gitsigns').diffthis()
          end)
        end,
        name = 'heirline_gitdiff',
      },
      {
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
          hl = { fg = 'yellow' },
        },
        {
          condition = function(self)
            return self.has_changes
          end,
          provider = ')',
        },
      },
    },
    { provider = ' ' },
  }
end

local SearchCount = {
  condition = function()
    return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  provider = function(self)
    local search = self.search
    return string.format('[%d/%d]', search.current, math.min(search.total, search.maxcount))
  end,
}

local MacroRec = {
  condition = function()
    return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
  end,
  provider = ' ',
  hl = { fg = 'orange', bold = true },
  heir_utils.surround({ '[', ']' }, nil, {
    provider = function()
      return vim.fn.reg_recording()
    end,
    hl = { fg = 'green', bold = true },
  }),
  update = {
    'RecordingEnter',
    'RecordingLeave',
  },
}

vim.opt.showcmdloc = 'statusline'
local ShowCmd = {
  condition = function()
    return vim.o.cmdheight == 0
  end,
  provider = '%3.5(%S%)',
}

function M.showcmd(opts)
  return {
    SearchCount,
    M.space(),
    MacroRec,
    M.space(),
    ShowCmd,
  }
end

function M.lazy_status(opts)
  opts = Util.tbl_extend({
    color = '',
  }, opts)

  return {
    provider = function()
      return require('lazy.status').updates() .. ' '
    end,
    condition = require('lazy.status').has_updates,
    hl = { fg = opts.color },
  }
end

function M.ruler(opts)
  opts = Util.tbl_extend({
    color = '',
  }, opts)

  return {
    flexible = true,
    hl = { fg = opts.color },
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    { provider = '%7(%l/%-3L%):%-2c' },
    { provider = '%l:%c' },
    { provider = '' },
  }
end

function M.nvim_version()
  return {
    static = {
      version = string.format(' NVIM v%s.%s.%s ', vim.version().major, vim.version().minor, vim.version().patch),
    },
    provider = function(self)
      return self.version
    end,
  }
end

function M.lsp(opts)
  opts = Util.tbl_extend({
    color = 'cyan',
  }, opts)

  return {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },
    provider = function()
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if #clients > 0 then
        return '󰒋 ' .. clients[1].name .. ' '
      end
    end,
    on_click = {
      callback = function()
        vim.schedule(function()
          vim.cmd('LspInfo')
        end)
      end,
      name = 'heirline_lspinfo',
    },
    hl = { fg = opts.color },
  }
end

function M.diagnostics(opts)
  opts = Util.tbl_extend({}, opts)

  return {
    condition = conditions.has_diagnostics,
    update = { 'DiagnosticChanged', 'BufEnter' },
    static = {
      error_icon = Config.icons.diagnostics.Error,
      warn_icon = Config.icons.diagnostics.Warn,
      info_icon = Config.icons.diagnostics.Info,
      hint_icon = Config.icons.diagnostics.Hint,
    },
    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,
    {
      provider = function(self)
        return self.errors > 0 and (self.error_icon .. ' ' .. self.errors .. ' ')
      end,
      hl = { fg = 'diag_error' },
    },
    {
      provider = function(self)
        return self.warns > 0 and (self.warn_icon .. ' ' .. self.warns .. ' ')
      end,
      hl = { fg = 'diag_warn' },
    },
    {
      provider = function(self)
        return self.infos > 0 and (self.info_icon .. ' ' .. self.infos .. ' ')
      end,
      hl = { fg = 'diag_info' },
    },
    {
      provider = function(self)
        return self.hints > 0 and (self.hint_icon .. ' ' .. self.hints .. ' ')
      end,
      hl = { fg = 'diag_hint' },
    },
  }
end

function M.neotree(opts)
  return {
    condition = function()
      return conditions.buffer_matches { filetype = { 'neo%-tree' } }
    end,
    provider = function()
      local state = require('neo-tree.sources.manager').get_state('filesystem')
      return state.path
    end,
  }
end

function M.oil(opts)
  return {
    condition = function()
      return conditions.buffer_matches { filetype = { 'oil' } }
    end,
    provider = function()
      local dir = require('oil').get_current_dir()
      if dir then
        return vim.fn.fnamemodify(dir, ':~')
      else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
      end
    end,
    hl = { fg = 'blue', bg = 'bg' },
  }
end

function M.setup(opts)
  opts = Util.tbl_extend({
    colors = {
      diag_warn = heir_utils.get_highlight('DiagnosticWarn').fg,
      diag_error = heir_utils.get_highlight('DiagnosticError').fg,
      diag_hint = heir_utils.get_highlight('DiagnosticHint').fg,
      diag_info = heir_utils.get_highlight('DiagnosticInfo').fg,
    },
  }, opts)
  heirline.load_colors(opts.colors)
end

return M
