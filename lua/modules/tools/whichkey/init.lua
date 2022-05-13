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
            ["/"] = {
                name = "packer",
                s = { "<cmd>PackerSync<CR>", "Packer Sync" },
                t = { "<cmd>PackerStatus<CR>", "Packer Status" },
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
                name = "finder(telescope)",
                f = { "<cmd>Telescope find_files<CR>", "Files" },
                b = { "<cmd>Telescope buffers<CR>", "Buffers" },
                g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
                s = { "<cmd>Telescope grep_string<CR>", "Grep String" },
                z = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy Find in Buffer" },
                ["/"] = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
                o = { "<cmd>Telescope oldfiles<CR>", "Old Files" },
                h = { "<cmd>Telescope frecency<CR>", "Frecency Files" },
                p = { "<cmd>Telescope projects<CR>", "Projects" },
                c = { "<cmd>Telescope neoclip<CR>", "Clipboard" },
                r = { "<cmd>Telescope resume<CR>", "Resume" },
                -- n = {"<cmd>Telescope file_browser<CR>", "File Browser"},
            },
            ["<Leader>"] = { "<cmd>Telescope<CR>", "Telescope" },
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
            border = "double",
        },
        -- function to run on opening the terminal
        on_open = function(term)
            -- vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        -- on_close = function(term)
        --     vim.cmd("Closing terminal")
        -- end,
        close_on_exit = true, -- close the terminal window when the process exits
        shade_terminals = true,
        shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
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

local setup = function()
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
end

return {
    setup = setup
}
