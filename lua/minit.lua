-- used for minimum vimrc debug
local fn = vim.fn
local packer_dir = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(packer_dir)) > 0 then
    packer_bootstrap = fn.system {'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_dir}
end

vim.cmd [[packadd packer.nvim]]
packer = require('packer')
packer.startup({
    function()
        use {'wbthomason/packer.nvim', opt = true}

        use {'neovim/nvim-lspconfig'}
        use {'williamboman/nvim-lsp-installer'}

        use {'ray-x/lsp_signature.nvim'}

        use {'hrsh7th/nvim-cmp'}
        use {'hrsh7th/cmp-nvim-lsp'}

        use {'L3MON4D3/LuaSnip'}
        use {'saadparwaiz1/cmp_luasnip'}

        use {'windwp/nvim-autopairs'}
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({border = "single"})
            end
        }
    }
})

if packer_bootstrap then
    packer.sync()
end

local on_attach = function(client, bufnr)
    -- other settings removed
    -- lsp_signature
    require("lsp_signature").on_attach()
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150
        }
    }
    if server.name == 'sumneko_lua' then
        opts.settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            }
        }
    end
    server:setup(opts)
end)

-- cmp configs --
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


local cmp = require('cmp')
cmp.setup {
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif require('luasnip').expand_or_jumpable() then
                    require('luasnip').expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end,
            {"i", "s"}
        ),
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif require('luasnip').jumpable(-1) then
                    require('luasnip').jump(-1)
                else
                    fallback()
                end
            end,
            {"i", "s"}
        ),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    experimental = {
        ghost_text = true
    }
}


require("luasnip").config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI"
}
require("luasnip.loaders.from_vscode").load()


require('nvim-autopairs').setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
