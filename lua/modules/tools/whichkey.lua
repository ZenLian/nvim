local wk = require('which-key')

local keymaps = {}

keymaps.basic = function()
    wk.register(
        {
        name = "editor(normal)",
        ["<C-h>"] = { "<C-w>h", "Move to window leftwards" },
        ["<C-l>"] = { "<C-w>l", "Move to window rightwards" },
        ["<C-k>"] = { "<C-w>k", "Move to window above" },
        ["<C-j>"] = { "<C-w>j", "Move to window below" },
        ["<M-j>"] = { "mz:m+<cr>`z", "Swap line down" },
        ["<M-k>"] = { "mz:m-2<cr>`z", "Swap line up" },
        H = { "^", "Start of line" },
        L = { "$", "End of line" },
        -- 使 Y 复制到行尾，和 D 一致
        Y = { "y$", "Yank to the end" },

        ["<Leader>w"] = { "<cmd>w!<CR>", "Save" },
        ["<Leader>q"] = { "<cmd>qa!<CR>", "Quit" },
        ["<Leader><Enter>"] = { "<cmd>noh<CR>", "Clear search highlight" },
    }
    )
    wk.register(
        {
            name = "editor(visual)",
            H = { "^", "Start of line" },
            L = { "$", "End of line" },
            Y = { '"+y', "Yank to clipboard" },
            ["<M-j>"] = { ":m'>+<cr>`<my`>mzgv`yo`z", "Swap line down" },
            ["<M-k>"] = { ":m'<-2<cr>`>my`<mzgv`yo`z", "Swap line up" },
            ["<"] = { "<gv", "Shift lines leftwards" },
            [">"] = { ">gv", "Shift lines rightwards" },
            ["<S-Tab>"] = { "<gv", "Shift lines leftwards" },
            ["<Tab>"] = { ">gv", "Shift lines rightwards" },
        },
        {
        mode = "v",
    }
    )
    wk.register(
        {
            name = "next",
        },
        {
        prefix = "]"
    }
    )
    wk.register(
        {
            name = "previous",
        },
        {
        prefix = "["
    }
    )
end

-- packer.nvim
keymaps.packer = function()
    wk.register(
        {
            ["p"] = {
                name = "packer",
                p = { "<cmd>PackerSync<CR>", "Packer Sync" },
                s = { "<cmd>PackerStatus<CR>", "Packer Status" },
                c = { "<cmd>PackerCompile<CR>", "Packer Complile" },
            },
        },
        { prefix = "<Leader>" }
    )
end

-- nvim-bufferline
keymaps.b = function()
    -- <Leader>b
    wk.register(
        {
            b = {
                name = "buffer",
                b = { "<cmd>BufferLinePick<CR>", "Pick buffer" },
                c = { "<cmd>BufferLinePickClose<CR>", "Pick buffer to close" },
                ["["] = { "<cmd>BufferLineCloseLeft<CR>", "Close Left buffers" },
                ["]"] = { "<cmd>BufferLineCloseRight<CR>", "Close right buffers" },
            },
        },
        { prefix = "<Leader>" }
    )
    wk.register(
        {
        ["[b"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous buffer" },
        ["]b"] = { "<cmd>BufferLineCycleNext<CR>", "Next buffer" },
    }
    )
end

-- telescope
keymaps.f = function()
    wk.register(
        {
            f = {
                name = "fuzzy find",
                f = { "<cmd>Telescope find_files<CR>", "Files" },
                b = { "<cmd>Telescope buffers<CR>", "Buffers" },
                g = { "<cmd>Telescope live_grep<CR>", "Grep" },
                w = { "<cmd>Telescope grep_string<CR>", "Word" },
                z = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy Find in Buffer" },
                ["/"] = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
                h = { "<cmd>Telescope frecency<CR>", "Frecency files" },
                p = { "<cmd>Telescope projects<CR>", "Projects" },
                c = { "<cmd>Telescope neoclip<CR>", "Clipboard" },
                r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
                n = { "<cmd>Telescope file_browser<CR>", "File Browser" },
                s = { "<cmd>SessionManager load_session<CR>", "Sessions" },
            },
            ["<Leader>"] = { "<cmd>Telescope resume<CR>", "Telescope Resume" },
        },
        { prefix = "<Leader>" }
    )

    local project_files = function()
        local telescope = require("telescope.builtin")
        local opts = {} -- define some options
        local ok = pcall(telescope.git_files, opts)
        if not ok then
            telescope.find_files(opts)
        end
    end
    wk.register(
        {
        ["<C-p>"] = { project_files, "Project(Git) Files" },
        ["<C-f>"] = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
    }
    )
end

-- git
keymaps.g = function()


    local Terminal = require('toggleterm.terminal').Terminal

    local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
            border = "single",
        },
        -- function to run on opening the terminal
        on_open = function(term)
            -- vim.cmd("startinsert!")
            vim.wo.winhl = "Normal:Terminal,FloatBorder:TerminalBorder"
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        -- on_close = function(term)
        --     vim.cmd("Closing terminal")
        -- end,
        close_on_exit = true, -- close the terminal window when the process exits
        shade_terminals = false,
    })

    local toggle_lazygit = function()
        lazygit:toggle()
    end
    wk.register(
        {
            g = {
                name = "Git",
                g = { toggle_lazygit, "Lazygit" },
                s = "Stage hunk",
                S = "Stage file",
                u = "Undo stage hunk",
                U = "Undo stage file",
                r = "Reset hunk",
                R = "Reset file",
                p = "Preview hunk",
                b = "Blame line",
            },
        },
        {
        prefix = "<Leader>"
    }
    )
    wk.register(
        {
        ["[g"] = "Previous git hunk",
        ["]g"] = "Next git hunk",
    }
    )
end

-- nvim-tree
keymaps.n = function()
    wk.register(
        {
            n = {
                name = "nvim tree",
                n = { "<cmd>NvimTreeFocus<CR>", "Focus" },
                f = { "<cmd>NvimTreeFindFile<CR>", "Find File" },
                r = { "<cmd>NvimTreeRefresh<CR>", "Refresh" },
            }
        },
        { prefix = "<Leader>" }
    )
    wk.register(
        {
        ["<C-n>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle Tree" },
    }
    )
end

-- Aerial(symbols outline)
keymaps.s = function()
    wk.register(
        {
        ["<C-t>"] = { "<cmd>AerialToggle<CR>", "Toggle Symbols" },
    }
    )
end

-- Zen/Focus
keymaps.z = function()
    wk.register(
        {
            z = {
                name = "Zen",
                z = { "<cmd>ZenMode<CR>", "ZenMode" },
                t = { "<cmd>Twilight<CR>", "Twilight" },
            },
        },
        {
        prefix = "<Leader>"
    }
    )
end

-- language
keymaps.l = function()
    wk.register(
        {
            l = {
                name = "language",
                f = { vim.lsp.buf.formatting, "File format" },
                c = { vim.lsp.buf.code_action, "Code action" },
                r = { vim.lsp.buf.rename, "Rename" },
                d = { "<cmd>Trouble<CR>", "Diagnostics" },
                l = { "<cmd>TroubleToggle<CR>", "Trouble Toggle" },
                -- TODO: should only works in markdown filetype
                p = { "<cmd>Glow<CR>", "Preview(Markdown)" } -- markdown preview
            }
        },
        {
        prefix = "<Leader>"
    }
    )
    wk.register({
        ["<Leader>lf"] = { vim.lsp.buf.range_formatting, "Format range" },
    }, {
        mode = "v"
    })
    wk.register({
        ["gd"] = { "<cmd>Telescope lsp_definitions<CR>", "Goto Definition" },
        ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
        ["gr"] = { "<cmd>Telescope lsp_references<CR>", "Goto references" },
        ["gR"] = { "<cmd>Troublferences<CR>", "Goto references(Trouble)" },
        ["K"] = { vim.lsp.buf.hover, "Hover doc" },
        -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        ["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
        ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
        ["<Leader>le"] = { vim.diagnostic.open_float, "Line diagnostic" },
    })
end


keymaps.dot = function()
    local function toggle_format_on_save()
        local config = require('config')
        config.format_on_save = not config.format_on_save
    end

    wk.register(
        {
            ["."] = {
                name = "config",
                f = { toggle_format_on_save, "Toggle format on save" }
            }
        }, {
        prefix = "<Leader>"
    })
end


wk.setup {
    plugins = {
        spelling = {
            enabled = true,
            suggestions = 20,
        }
    }
}
for _, fn in pairs(keymaps) do
    fn()
end
