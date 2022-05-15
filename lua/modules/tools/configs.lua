local configs = {}

configs.telescope = function()
    -- file_browser actions
    -- TODO: 这时插件还没加载， extensions 会报错，所以把函数放在闭包里延后执行
    local fb_actions = function(action)
        return function(...)
            local actions = require('telescope').extensions.file_browser.actions
            return actions[action](...)
        end
    end

    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-/>"] = "which_key",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-j>"] = "move_selection_next"
                }
            },
            prompt_prefix = ' ',
            selection_caret = ' ',
            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = {
                prompt_position = "top",
            },
            -- border = false,
            borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            history = {
                path = vim.fn.stdpath('data') .. '/databases/telescope_history.sqlite3',
                limit = 100,
            }
        },
        extensions = {
            frecency = {
                db_root = vim.fn.stdpath('data') .. '/databases',
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
            },
            file_browser = {
                theme = 'ivy',
                initial_mode = 'normal',
                mappings = {
                    n = {
                        ["a"] = fb_actions('create'),
                        ["l"] = "select_default",
                        ["h"] = fb_actions('goto_parent_dir'),
                    }
                }
            }
        }
    }

    -- if not packer_plugins["nvim-neoclip.lua"].loaded then
    --     vim.cmd [[packadd nvim-neoclip.lua]]
    -- end
    require('telescope').load_extension('neoclip')
end

configs.neoclip = function()
    require('neoclip').setup {
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
        shell = vim.o.shell, -- change the default shell
    }

    -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua LazygitToggle()<CR>", {noremap = true, silent = true})
end

configs.which_key = function()
    require('modules.tools.whichkey').setup()
end

return configs
