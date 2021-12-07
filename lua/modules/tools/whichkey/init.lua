local wk = require('which-key')

local leader = {}

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

leader.b = function ()
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

leader.g = function ()
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
            -- TODO: move out of here
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
    wk.register(
        {
            ["[g"] = "Previous git hunk",
            ["]g"] = "Next git hunk",
        }
    )
end

leader.n = function ()
    wk.register(
        {
            n = {
                name = "Nvim Tree",
                n = {"<cmd>NvimTreeToggle<CR>", "Toggle Tree"},
                f = {"<cmd>NvimTreeFindFile<CR>", "Find File"},
                r = {"<cmd>NvimTreeRefresh<CR>", "Refresh"},
            }
        },
        { prefix = "<Leader>" }
    )
    wk.register(
        {
            ["<C-n>"] = {"<cmd>NvimTreeToggle<CR>", "Toggle Tree"},
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
    for _, fn in pairs(leader) do
        fn()
    end
end

return {
    setup = setup
}
