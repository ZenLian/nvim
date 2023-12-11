local conditions = require('heirline.conditions')
local LazyUtil = require('lazyvim.util')

local M = {
  trim = {
    provider = '%<',
  },
  align = {
    provider = '%=',
  },
  space = {
    provider = ' ',
  },
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
  V = 'mauve',
  R = 'mauve',
  C = 'peach',
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
    provider = provider or '█',
    hl = function()
      return { fg = get_mode_color() }
    end,
    update = { 'ModeChanged' },
  }
end

function M.root_dir(opts)
  opts = vim.tbl_extend('force', {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = '󱉭',
    color = '',
  }, opts or {})
  local function get()
    local cwd = LazyUtil.root.cwd()
    local root = LazyUtil.root.get { normalize = true }
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
  opts = vim.tbl_extend('force', {
    color = '',
  }, opts or {})

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
  opts = vim.tbl_extend('force', {
    icon_only = false,
  }, opts or {})

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
  opts = vim.tbl_extend('force', {
    relative = 'cwd',
    modified_color = 'green',
  }, opts or {})

  return {
    init = function(self)
      self.path = vim.fn.expand('%:p') --[[@as string]]

      local root = LazyUtil.root.get { normalize = true }
      local cwd = LazyUtil.root.cwd()
      if opts.relative == 'cwd' and self.path:find(cwd, 1, true) == 1 then
        self.path = self.path:sub(#cwd + 2)
      else
        self.path = self.path:sub(#root + 2)
      end

      local parts = vim.split(self.path, '[\\/]')
      if #parts > 3 then
        parts = { parts[1], '…', parts[#parts - 1], parts[#parts] }
      end

      self.basename = parts[#parts]

      if #parts > 1 then
        parts[#parts] = nil
        self.pathname = table.concat(parts, '/')
      else
        self.pathname = nil
      end
    end,
    {
      provider = ' ',
    },
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
      provider = '[]',
      hl = { fg = 'green' },
    },
  }
end

function M.git(opts)
  opts = vim.tbl_extend('force', {
    color = '',
  }, opts or {})

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
            require('telescope.builtin').git_branches()
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

function M.noice_command(opts)
  opts = vim.tbl_extend('force', {
    color = '',
  }, opts or {})

  return {
    provider = function()
      return require('noice').api.status.command.get() .. ' '
    end,
    condition = function()
      return package.loaded['noice'] and require('noice').api.status.command.has()
    end,
    hl = { fg = opts.color },
  }
end

function M.noice_mode(opts)
  opts = vim.tbl_extend('force', {
    color = '',
  }, opts or {})

  return {
    provider = function()
      return require('noice').api.status.mode.get() .. ' '
    end,
    condition = function()
      return package.loaded['noice'] and require('noice').api.status.mode.has()
    end,
    hl = { fg = opts.color },
  }
end

function M.lazy_status(opts)
  opts = vim.tbl_extend('force', {
    color = '',
  }, opts or {})

  return {
    provider = function()
      return require('lazy.status').updates() .. ' '
    end,
    condition = require('lazy.status').has_updates,
    hl = { fg = opts.color },
  }
end

function M.ruler(opts)
  opts = vim.tbl_extend('force', {
    color = '',
  }, opts or {})

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
  opts = vim.tbl_extend('force', {
    color = '',
  }, opts or {})

  return {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },
    provider = function()
      local clients = LazyUtil.lsp.get_clients { bufnr = 0 }
      if #clients > 0 then
        return '󰒋 ' .. clients[1].name .. ' '
      end
    end,
    hl = { fg = opts.color },
  }
end

return M
