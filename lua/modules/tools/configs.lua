local home = require('core.globals').home_dir

local configs = {}

configs['nvim-telescope/telescope.nvim'] = function()
    if not packer_plugins["nvim-neoclip.lua"].loaded then
        vim.cmd [[packadd nvim-neoclip.lua]]
    end
    require('telescope').load_extension('neoclip')

    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-j>"] = "move_selection_next"
                }
            },
        },
        extensions = {
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = {"*.git/*", "*/tmp/*"},
            },
        }
    }
end

configs["AckslD/nvim-neoclip.lua"] = function()
    if not packer_plugins["sqlite.lua"].loaded then
        vim.cmd [[packadd sqlite.lua]]
    end
    require('neoclip').setup{
        enable_persistant_history = true,
    }
end

configs['kyazdani42/nvim-tree.lua'] = function()
    vim.g.nvim_tree_respect_buf_cwd = 1
    require("nvim-tree").setup({
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        },
    })
    require('nvim-tree').setup()
end

configs["akinsho/toggleterm.nvim"] = function()
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
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        -- function to run on closing the terminal
        on_close = function(term)
            vim.cmd("Closing terminal")
        end,
        close_on_exit = true, -- close the terminal window when the process exits
        shade_terminals = true,
        shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
end

configs["rmagatti/auto-session"] = function ()
    require('auto-session').setup {
        log_level = 'info',
        auto_session_enable_last_session = true,
        auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = nil
    }
end

configs["rmagatti/session-lens"] = function ()
    require('session-lens').setup { }
end

configs['folke/which-key.nvim'] = function()
    local wk = require('which-key')
    wk.setup()
    wk.register(
    {
        z = {
            name = "zen",
            z = {"<cmd>ZenMode<CR>", "ZenMode"},
            t = {"<cmd>Twilight<CR>", "Twilight"},
        }
    },
    {
        prefix = "<Leader>"
    }
    )
end

return configs
