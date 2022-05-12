local configs = {}

configs.telescope = function()
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-j>"] = "move_selection_next"
                }
            },
            history = {
                path = vim.fn.stdpath('data')..'/databases/telescope_history.sqlite3',
                limit = 100,
            }
        },
        extensions = {
            frecency = {
                db_root = vim.fn.stdpath('data')..'/databases',
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = {"*.git/*", "*/tmp/*"},
            },
        }
    }

    -- if not packer_plugins["nvim-neoclip.lua"].loaded then
    --     vim.cmd [[packadd nvim-neoclip.lua]]
    -- end
    require('telescope').load_extension('neoclip')
end

configs.neoclip = function()
    require('neoclip').setup{
        enable_persistent_history = true,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        keys = {
            telescope = {
                i = {
                    select = '<cr>',
                    paste = '<c-p>',
                    paste_behind = '<c-l>',
                    custom = {},
                },
                n = {
                    select = '<cr>',
                    paste = 'p',
                    paste_behind = 'P',
                    custom = {},
                }
            },
        },
    }
end

configs.nvim_tree = function()
    vim.g.nvim_tree_respect_buf_cwd = 1
    require("nvim-tree").setup({
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
    })
end

configs.toggleterm = function()
    require("toggleterm").setup {
        -- size can be a number or function which is passed the current terminal
        size = function(term)
            if term.direction == "horizontal" then
                return 20
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.40
            end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = "vertical",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell -- change the default shell
    }

    local Terminal  = require('toggleterm.terminal').Terminal

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
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        -- function to run on closing the terminal
        -- on_close = function(term)
        --     vim.cmd("Closing terminal")
        -- end,
        close_on_exit = true, -- close the terminal window when the process exits
        shade_terminals = true,
        shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    })

    _G.LazygitToggle = function()
      lazygit:toggle()
    end

    -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua LazygitToggle()<CR>", {noremap = true, silent = true})
end

configs.which_key = function()
    require('modules.tools.whichkey').setup()
end

return configs
