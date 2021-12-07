local wk = require('which-key')



local register_basic = function ()
    wk.register(
        {
            name = "Editor(Normal)",
            ["<C-h>"] = {"<C-w>h", "Move to window leftwards"},
            ["<C-l>"] = {"<C-w>l", "Move to window rightwards"},
            ["<C-k>"] = {"<C-w>k", "Move to window above"},
            ["<C-j>"] = {"<C-w>j", "Move to window below"},
            ["<M-j>"] = {"mz:m+<cr>`z", "Swap line down"},
            ["<M-k>"] = {"mz:m-2<cr>`z", "Swap line up"},
            H = {"^", "Start of line"},
            L = {"$", "End of line"},
            ["<Leader>w"] = {"<cmd>w!<CR>", "Save buffer"},
            ["<Leader>q"] = {"<cmd>qa!<CR>", "Quit"},
            ["<Leader><Enter>"] = {"<cmd>noh<CR>", "Clear search highlight"},
        }
    )
    wk.register(
        {
            name = "Editor(Visual)",
            H = {"^", "Start of line"},
            L = {"$", "End of line"},
            ["<M-j>"] = {":m'>+<cr>`<my`>mzgv`yo`z", "Swap line down"},
            ["<M-k>"] = {":m'<-2<cr>`>my`<mzgv`yo`z", "Swap line up"},
            ["<"] = {"<gv", "Shift lines leftwards"},
            [">"] = {">gv", "Shift lines rightwards"},
            ["<S-Tab>"] = {"<gv", "Shift lines leftwards"},
            ["<Tab>"] = {">gv", "Shift lines rightwards"},
        },
        {
            mode = "v",
        }
    )
    wk.register(
        {
            name = "Next",
        },
        {
            prefix = "]"
        }
    )
    wk.register(
        {
            name = "Previous",
        },
        {
            prefix = "["
        }
    )
end

local register_buffer = function ()
    -- <Leader>b
    wk.register(
        {
            b = {
                name = "Buffer",
                b = {"<cmd>BufferLinePick<CR>", "Pick buffer"},
                c = {"<cmd>BufferLinePickClose<CR>", "Pick buffer to close"},
                ["["] = {"<cmd>BufferLineCyclePrev<CR>", "Previous buffer"},
                ["]"] = {"<cmd>BufferLineCycleNext<CR>", "Next buffer"},
            },
        },
        { prefix = "<Leader>" }
    )
    wk.register(
        {
            ["[b"] = {"<cmd>BufferLineCyclePrev<CR>", "Previous buffer"},
            ["]b"] = {"<cmd>BufferLineCycleNext<CR>", "Next buffer"},
        }
    )
end

local register_git = function ()
    wk.register(
        {
            g = {
                name = "Git",
                g = {"<cmd>lua LazygitToggle()<CR>", "Lazygit"},
                s = "Stage hunk",
                S = "Stage file",
                u = "Undo stage hunk",
                U = "Undo stage file",
                r = "Reset hunk",
                R = "Reset file",
                p = "Preview hunk",
                b = "Blame line",
            },
            z = {
                name = "Zen",
                z = {"<cmd>ZenMode<CR>", "ZenMode"},
                t = {"<cmd>Twilight<CR>", "Twilight"},
            }
        },
        {
            prefix = "<Leader>"
        }
    )
end

local setup = function ()
    wk.setup {
        plugins = {
            spelling = {
                enabled = true,
                suggestions = 20,
            }
        }
    }
    register_basic()
    register_buffer()
    register_git()
end

return {
    setup = setup
}