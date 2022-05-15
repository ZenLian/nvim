local configs = {}

configs.lspconfig = function()
    -- 自定义 server
    require('modules.completion.lspserver').setup()
    -- configs
    require('modules.completion.lspconfig').setup()
end

configs.lspsaga = function()
    require 'lspsaga'.setup {}
end

configs.cmp = function()
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- local kind_icons = {
    --     Text = "",
    --     Method = "",
    --     Function = "",
    --     Constructor = "",
    --     Field = "",
    --     Variable = "",
    --     Class = "ﴯ",
    --     Interface = "",
    --     Module = "",
    --     Property = "ﰠ",
    --     Unit = "",
    --     Value = "",
    --     Enum = "",
    --     Keyword = "",
    --     Snippet = "",
    --     Color = "",
    --     File = "",
    --     Reference = "",
    --     Folder = "",
    --     EnumMember = "",
    --     Constant = "",
    --     Struct = "",
    --     Event = "",
    --     Operator = "",
    --     TypeParameter = ""
    -- }

    local cmp = require('cmp')
    cmp.setup {
        mapping = {
            ["<CR>"] = cmp.mapping.confirm({
                select = true
            }),
            ["<C-p>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "c" }),
            ["<C-n>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "c" }),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm({
                        select = true
                    })
                    -- cmp.select_next_item()
                elseif require('luasnip').expand_or_jumpable() then
                    require('luasnip').expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif require('luasnip').jumpable(-1) then
                    require('luasnip').jump(-1)
                else
                    fallback()
                end
            end, { "i", "s", "c" }),
            ["<C-h>"] = function(fallback)
                if require("luasnip").jumpable(-1) then
                    vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
                else
                    fallback()
                end
            end,
            ["<C-l>"] = function(fallback)
                if require("luasnip").expand_or_jumpable() then
                    vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
                else
                    fallback()
                end
            end
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
        }, {
            { name = 'buffer' },
            { name = 'path' },
            -- { name = 'cmdline' },
        }, {
            { name = 'calc' },
            { name = 'dictionary', keyword_length = 2 }
        }),
        completion = {
            completeopt = 'menu,menuone,noinsert'
        },
        formatting = {
            format = require('lspkind').cmp_format({
                mode = 'symbol',
                max_width = 50,
                before = function(entry, vim_item)
                    -- Source menu
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[Lua]",
                        luasnip = "[Snip]",
                        buffer = "[Buff]",
                        path = "[Path]",
                        calc = "[Calc]",
                        dictionary = "[Dict]",
                        cmdline = "[CMD]",
                        cmdline_history = "[HIST]",
                    })[entry.source.name]
                    return vim_item
                end
            }),
            -- format = function(entry, vim_item)
            --     -- Kind icons
            --     vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            --     -- Source
            --     vim_item.menu = ({
            --         nvim_lsp = "[LSP]",
            --         nvim_lua = "[Lua]",
            --         luasnip = "[LuaSnip]",
            --         buffer = "[Buff]",
            --         path = "[Path]",
            --         calc = "[Calc]",
            --         dictionary = "[Dict]",
            --         cmdline = "[CMD]",
            --         cmdline_history = "[HIST]",
            --         nvim_lsp_document_symbol = "[SYMBOL]"
            --     })[entry.source.name]
            --     return vim_item
            -- end
        },
        experimental = {
            ghost_text = true
        }
    }

    cmp.setup.cmdline('/', {
        sources = { {
            name = 'buffer'
        }, {
            name = 'cmdline_history'
        }, {
            name = 'nvim_lsp_document_symbol'
        } }
    })

    cmp.setup.cmdline(':', {
        sources = { {
            name = 'path'
        }, {
            name = 'cmdline'
        }, {
            name = 'cmdline_history'
        } }
    })

    require("cmp_dictionary").setup({
        dic = {
            ["*"] = { "/usr/share/dict/words" }
        },
        -- The following are default values.
        -- exact = 2,
        first_case_insensitive = true,
        -- document = false,
        -- document_command = "wn %s -over",
        async = true
        -- capacity = 5,
        -- debug = false,
    })
end

configs.luasnip = function()
    require("luasnip").config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI"
    }
    require("luasnip.loaders.from_vscode").load()
end

configs.autopairs = function()
    require('nvim-autopairs').setup()
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({
        map_char = {
            tex = ''
        }
    }))
    cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
end

return configs
