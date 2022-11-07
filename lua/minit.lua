-- used for minimum vimrc debug

local function setup_packer()
  local fn = vim.fn
  local packer_dir = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

  local packer_bootstrap = nil
  if fn.empty(fn.glob(packer_dir)) > 0 then
    packer_bootstrap =
      fn.system { 'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_dir }
  end

  vim.cmd([[packadd packer.nvim]])
  local packer = require('packer')
  packer.startup {
    function(use)
      use { 'wbthomason/packer.nvim', opt = true }
      use {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        requires = {
          -- { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
          { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
          { 'uga-rosa/cmp-dictionary', after = 'nvim-cmp', module = 'cmp_dictionary' },
        },
        config = function()
          local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
          end

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
              -- nvim_lua = "[Lua]",
              luasnip = '[Snip]',
              -- buffer = '[Buff]',
              path = '[Path]',
              calc = '[Calc]',
              dictionary = '[Dict]',
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
                  fallback()
                end
              end, { 'i', 'c' }),
              ['<C-n>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end, { 'i', 'c' }),
              ['<C-d>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-e>'] = cmp.mapping(cmp.mapping.close(), { 'i', 'c' }),
              ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.confirm {
                    select = true,
                  }
                -- cmp.select_next_item()
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
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              end,
            },
            sources = cmp.config.sources({
              -- { name = 'nvim_lua' },
              { name = 'nvim_lsp' },
              { name = 'luasnip' }, -- For luasnip users.
              { name = 'nvim_lsp_signature_help' },
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
              -- {
              --   name = 'buffer',
              -- },
              {
                name = 'cmdline_history',
              },
              {
                name = 'nvim_lsp_document_symbol',
              },
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
              ['*'] = { '/usr/share/dict/words' },
            },
            -- The following are default values.
            -- exact = 2,
            first_case_insensitive = true,
            -- document = false,
            -- document_command = "wn %s -over",
            async = true,
            -- capacity = 5,
            -- debug = false,
          }
        end,
      }
      use {
        'L3MON4D3/LuaSnip',
        module = 'luasnip',
        requires = 'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip').config.set_config {
            history = true,
            updateevents = 'TextChanged,TextChangedI',
          }
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      }
    end,
    config = {
      display = {
        open_fn = function()
          return require('packer.util').float { border = 'single' }
        end,
      },
    },
  }

  if packer_bootstrap then
    packer.sync()
  end
end

local function create_autocmd()
  vim.o.showmode = false
  local group = vim.api.nvim_create_augroup('init.lua', { clear = true })

  vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    group = group,
    callback = function()
      print('here!')
      local pos = vim.fn.line([['"]])
      if pos > 1 and pos <= vim.fn.line('$') then
        vim.cmd([[normal! g'"]])
      end
    end,
  })
end

create_autocmd()
setup_packer()
