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

    local dropdown = {
        theme = 'dropdown',
        previewer = false,
        height = 25,
    }

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
            layout_strategy = 'bottom_pane',
            layout_config = {
                prompt_position = "top",
                height = 25,
            },
            -- border = false,
            borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
            history = {
                path = vim.fn.stdpath('data') .. '/databases/telescope_history.sqlite3',
                limit = 100,
            },
        },
        pickers = {
            builtin = dropdown,
            find_files = dropdown,
            git_files = dropdown,
            oldfiles = dropdown,
        },
        extensions = {
            frecency = {
                db_root = vim.fn.stdpath('data') .. '/databases',
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
            },
            file_browser = {
                -- theme = 'ivy',
                initial_mode = 'normal',
                mappings = {
                    n = {
                        ["a"] = fb_actions('create'),
                        ["l"] = "select_default",
                        ["h"] = fb_actions('goto_parent_dir'),
                    }
                }
            },
            themes = dropdown,
        }
    }

    -- if not packer_plugins["nvim-neoclip.lua"].loaded then
    --     vim.cmd [[packadd nvim-neoclip.lua]]
    -- end
    require('telescope').load_extension('neoclip')
    -- require('telescope').load_extension('themes')
    require('telescope').load_extension('notify')
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

configs.session = function()
    local Path = require('plenary.path')
    require('session_manager').setup({
        sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
        path_replacer = '__', -- The character to which the path separator will be replaced for session files.
        colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
            'gitcommit',
        },
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    })
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
