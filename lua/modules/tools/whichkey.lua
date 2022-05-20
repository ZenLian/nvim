local wk = require('which-key')
local util = require('core.util')
local map = util.map


-- Move to window
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize window
map("n", "<S-Up>", ":resize +2<CR>")
map("n", "<S-Down>", ":resize -2<CR>")
map("n", "<S-Left>", ":vertical resize -2<CR>")
map("n", "<S-Right>", ":vertical resize +2<CR>")

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Indent without leaving Visual Mode
map("v", "<", "<gv")
map("v", ">", ">gv")
-- Indent with tab in Visual Mode
map("v", "<S-Tab>", "<gv")
map("v", "<Tab>", ">gv")

-- Clear search with <esc>
map("n", "<esc>", ":noh<cr>")

-- Paste block
map("n", "]p", ":pu<cr>")
map("n", "[p", ":pu!<cr>")
-- Yank to end of line, consistence with D/C
map("n", "Y", "y$")
-- Yank to system clipboard
map("v", "Y", '"+y')
-- H = { "^", "Start of line" },
-- L = { "$", "End of line" },

-- windows like shortcut
-- Save
map("i", "<C-s>", "<esc>:w<cr>")
map("n", "<C-s>", "<esc>:w<cr>")
map("v", "<C-s>", "<esc>:w<cr>")
-- Delete to start
map("i", "<C-BS>", "<C-u>")

-- n/N always search forward/backward
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true })
map("v", "n", "'Nn'[v:searchforward]", { expr = true })
map("o", "n", "'Nn'[v:searchforward]", { expr = true })
map("n", "N", "'nN'[v:searchforward]", { expr = true })
map("v", "N", "'nN'[v:searchforward]", { expr = true })
map("o", "N", "'nN'[v:searchforward]", { expr = true })

--
-- plugins
--
map("n", "[b", "<cmd>BufferLineCyclePrev<CR>")
map("n", "]b", "<cmd>BufferLineCycleNext<CR>")
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

local project_files = function()
    local telescope = require("telescope.builtin")
    local opts = {} -- define some options
    local ok = pcall(telescope.git_files, opts)
    if not ok then
        telescope.find_files(opts)
    end
end

map("n", "<C-p>", project_files)
-- map("n", "<C-t>", "<cmd>AerialToggle<CR>")

--
-- leader keymaps
--
local leader = {
    p = {
        name = "packer",
        p = { "<cmd>PackerSync<CR>", "Packer Sync" },
        s = { "<cmd>PackerStatus<CR>", "Packer Status" },
        c = { "<cmd>PackerCompile<CR>", "Packer Complile" },
    },
    b = {
        name = "buffer",
        b = { "<cmd>e #<CR>", "Cycle Buffer" },
        g = { "<cmd>BufferLinePick<CR>", "Goto buffer" },
        c = { "<cmd>BufferLinePickClose<CR>", "Pick buffer to close" },
        ["["] = { "<cmd>BufferLineCloseLeft<CR>", "Close Left buffers" },
        ["]"] = { "<cmd>BufferLineCloseRight<CR>", "Close right buffers" },
        p = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
        n = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
        D = { "<cmd>bd<CR>", "Delete Buffer & Window" },
    },
    g = {
        name = "git",
        g = {
            function()
                util.float_terminal("lazygit")
            end,
            "LazyGit"
        },
        b = { "<cmd>Telescope git_branches<CR>", "Branches" },
        c = { "<cmd>Telescope git_commits<CR>", "Commits" },
        s = { "<cmd>Telescope git_status<CR>", "Status" },
        -- d = DiffViewOpen
        h = {
            -- defined by gitsigns
            name = "hunk",
            s = "Stage hunk",
            S = "Stage file",
            u = "Unstage hunk",
            U = "Unstage file",
            r = "Reset hunk",
            R = "Reset file",
            p = "Preview hunk",
            b = "Blame line",
        },
    },
    f = {
        name = "files",
        ["/"] = { "<cmd>NvimTreeFocus<CR>", "Focus NvimTree" },
        f = { "<cmd>Telescope find_files<CR>", "Find Files" },
        r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
        h = { "<cmd>Telescope frecency<CR>", "Frecency files" },
    },
    o = {
        name = "open",
        g = { "<cmd>Glow<CR>", "Glow" } -- markdown preview
    },
    s = {
        name = "search",
        b = { "<cmd>Telescope buffers<CR>", "Buffers" },
        g = { "<cmd>Telescope live_grep<CR>", "Grep" },
        w = { "<cmd>Telescope grep_string<CR>", "Current word" },
        z = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy Find in Buffer" },
        ["/"] = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
        c = { "<cmd>Telescope neoclip<CR>", "Clipboard" },
        n = { "<cmd>Telescope file_browser<CR>", "File Browser" },
        --TODO: move
        -- s = { "<cmd>SessionManager load_session<CR>", "Sessions" },
    },
    q = {
        name = "quit",
        q = { "<cmd>qa<cr>", "Quit" },
        Q = { "<cmd>qa<cr>", "Force quit" },
    },
    x = {
        name = "errors",
        x = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble" },
    },
    z = {
        name = "zen",
        z = { "<cmd>ZenMode<CR>", "ZenMode" },
        r = { "lua require('zen-mode').reset()<cr>", "Reset ZenMode" },
        t = { "<cmd>Twilight<CR>", "Twilight" },
    },
    ["/"] = {
        name = "toggle",
        f = {
            require('modules.completion.lspconfig.formatting').toggle,
            "Format on save"
        },
        s = {
            function()
                util.toggle("spell")
            end,
            "Spelling"
        },
        w = {
            function()
                util.toggle("wrap")
            end,
            "Word wrap"
        },
        n = {
            function()
                util.toggle("relativenumber", true)
                util.toggle("number")
            end,
            "Line Numbers"
        }
    },
    ["<Leader>"] = { "<cmd>Telescope resume<CR>", "Telescope Resume" },
}

wk.setup {
    plugins = {
        spelling = {
            enabled = true,
            suggestions = 20,
        }
    }
}

wk.register(leader, { prefix = "<Leader>" })
