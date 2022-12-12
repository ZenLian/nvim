local config = function()
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  -- local has_words_before = function()
  --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  -- end

  local kind_icons = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '',
    -- Unit = "塞",
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = '',
  }

  local cmp_fmt = function(entry, item)
    item.kind = string.format('%s', kind_icons[item.kind])
    -- Source menu
    item.menu = ({
      nvim_lsp = '[LSP]',
      luasnip = '[SNIP]',
      buffer = '[BUFF]',
      path = '[PATH]',
      calc = '[CALC]',
      dictionary = '[DICT]',
      cmdline = '[CMD]',
      cmdline_history = '[HIST]',
    })[entry.source.name]
    return item
  end

  local cmp = require('cmp')
  cmp.setup {
    mapping = {
      ['<CR>'] = cmp.mapping.confirm {
        select = true,
      },
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          -- cmp.complete()
          fallback()
        end
      end, { 'i', 'c' }),
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          -- cmp.complete()
          fallback()
        end
      end, { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.scroll_docs(-4)
        else
          fallback()
        end
      end),
      ['<C-u>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.scroll_docs(4)
        else
          fallback()
        end
      end),
      ['<C-e>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm {
            select = true,
          }
        elseif require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        -- elseif has_words_before() then
        --   cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require('luasnip').jumpable(-1) then
          require('luasnip').jump(-1)
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
      ['<C-h>'] = function(fallback)
        if require('luasnip').jumpable(-1) then
          vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
        else
          fallback()
        end
      end,
      ['<C-l>'] = function(fallback)
        if require('luasnip').expand_or_jumpable() then
          vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
        else
          fallback()
        end
      end,
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      -- { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      -- { name = 'nvim_lsp_signature_help' },
      { name = 'buffer' },
    }, {
      { name = 'path' },
      -- { name = 'cmdline' },
      { name = 'calc' },
      { name = 'dictionary', keyword_length = 2, max_item_count = 10 },
    }),
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    formatting = {
      format = cmp_fmt,
    },
    experimental = {
      ghost_text = {
        hl_group = 'NonText',
      },
    },
  }

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' },
      { name = 'cmdline_history' },
      { name = 'nvim_lsp_document_symbol' },
    },
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'cmdline' },
      { name = 'cmdline_history', max_item_count = 5 },
    }, {
      { name = 'path' },
    }),
  })

  require('cmp_dictionary').setup {
    dic = {
      ['*'] = { '~/.config/nvim/spell/english.dict', '/usr/share/dict/words' },
    },
    -- The following are default values.
    -- exact = 2,
    -- first_case_insensitive = false,
    -- document = false,
    -- document_command = "wn %s -over",
    async = true,
    -- max_items = 1000,
    -- capacity = 5,
    -- debug = false,
  }
end

return { config = config }
