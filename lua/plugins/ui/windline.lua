local windline = require('windline')
local helper = require('windline.helpers')
local b_components = require('windline.components.basic')
local state = _G.WindLine.state
local lsp_comps = require('windline.components.lsp')
local git_comps = require('windline.components.git')

local hl_list = {
    default  = { 'white', 'black' },
    White    = { 'white', 'black' },
    Black    = { 'black', 'white' },
    Blue     = { 'blue', 'black' },
    Green    = { 'green', 'black' },
    Red      = { 'red', 'black' },
    Yellow   = { 'yellow', 'black' },
    Cyan     = { 'cyan', 'black' },
    Magenta  = { 'magenta', 'black' },
    Inactive = { 'InactiveFg', 'InactiveBg' },
    Active   = { 'ActiveFg', 'ActiveBg' },
}
local basic = {}

local breakpoint_width = 90
basic.divider = { b_components.divider, '' }
basic.bg = { ' ', 'StatusLine' }

local colors_mode = {
    Normal = hl_list.Blue,
    Insert = hl_list.Green,
    Visual = hl_list.Yellow,
    Replace = hl_list.Yellow,
    Command = hl_list.Magenta,
}

basic.vi_mode = {
    name = 'vi_mode',
    hl_colors = colors_mode,
    text = function()
        return { { '  ', state.mode[2] } }
    end,
}
basic.square_mode = {
    hl_colors = colors_mode,
    text = function()
        return { { '▊', state.mode[2] } }
    end,
}

basic.file = {
    name = 'file',
    hl_colors = hl_list,
    text = function()
        return {
            { ' ', '' },
            { b_components.cache_file_name('[No Name]', 'unique'), 'White' },
            { ' ', '' },
            { b_components.file_modified(' '), 'Green' },
        }
    end,
}

local icon_comp = b_components.cache_file_icon({ default = '', hl_colors = hl_list.default })
basic.file_right = {
    hl_colors = hl_list,
    text = function(bufnr)
        return {
            { b_components.line_col_lua, 'White' },
            { b_components.progress_lua, '' },
            { ' ', '' },
            { b_components.file_encoding(), '' },
            { ' ', '' },
            icon_comp(bufnr),
            { ' ', '' },
            { b_components.cache_file_type({ icon = false }), 'White' },
            { ' ', '' },
        }
    end,
}

basic.git = {
    name = 'git',
    hl_colors = hl_list,
    width = breakpoint_width,
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                { git_comps.git_branch(), 'Magenta' },
                { git_comps.diff_added({ format = ' +%s', show_zero = false }), 'Green' },
                { git_comps.diff_removed({ format = ' -%s', show_zero = false }), 'Red' },
                { git_comps.diff_changed({ format = ' ~%s', show_zero = false }), 'Blue' },
            }
        end
        return ''
    end,
}

local quickfix = {
    filetypes = { 'qf', 'Trouble' },
    active = {
        { '🚦', { 'white', 'red' } },
        { ' Quickfix ', { 'red', 'black' } },
        -- { helper.separators.slant_right, { 'blue', 'black_light' } },
        {
            function()
                return vim.fn.getqflist({ title = 0 }).title
            end,
            { 'blue', 'InactiveBg' },
        },
        { ' Total : %L ', { 'blue', 'InactiveBg' } },
        -- { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
        -- { ' ', { 'InactiveFg', 'InactiveBg' } },
        basic.divider,
        -- { helper.separators.slant_right, { 'InactiveBg', 'red' } },
        { '🚦', { 'black', 'red' } },
    },

    always_active = true,
    show_last_status = true,
}

local explorer = {
    filetypes = { 'fern', 'NvimTree', 'lir' },
    active = {
        { '  Explorer ', { 'InactiveFg', 'blue' } },
        -- { helper.separators.slant_right, { 'red', 'NormalBg' } },
        { b_components.divider, { 'white', 'InactiveBg' } },
        -- { b_components.cache_file_type({ icon = false }), { 'white', 'NormalBg' } },
    },
    always_active = true,
    show_last_status = true,
}

local terminal = {
    filetypes = { 'toggleterm' },
    active = {
        { b_components.divider, hl_list.Black },
        {
            function()
                return string.format("  terminal(%s) ", vim.b.toggle_number)
            end,
            { 'black', 'red' }
        },
        { b_components.divider, hl_list.Black },
    },
    inactive = {
        { b_components.divider, hl_list.Inactive },
        {
            function(bufnr)
                local num = vim.api.nvim_buf_get_var(bufnr, "toggle_number")
                return string.format("  terminal(%s) ", num)
            end,
            hl_list.Inactive
        },
        { b_components.divider, hl_list.Inactive },
    }
}

basic.lsp_info = {
    name = 'lsp_info',
    hl_colors = hl_list,
    width = breakpoint_width,
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                { lsp_comps.lsp_error({ format = '  %s', show_zero = false }), 'Red' },
                { lsp_comps.lsp_warning({ format = '  %s', show_zero = false }), 'Yellow' },
                { lsp_comps.lsp_hint({ format = '  %s', show_zero = false }), 'Green' },
                { ' ' },
                { lsp_comps.lsp_name(), 'Blue' },
            }
        end
        return ''
    end,
}

local default = {
    filetypes = { 'default' },
    active = {
        basic.square_mode,
        basic.vi_mode,
        basic.git,
        basic.file,
        basic.divider,
        basic.lsp_info,
        basic.file_right,
        basic.square_mode,
    },
    inactive = {
        { b_components.divider, hl_list.Inactive },
        { b_components.full_file_name, hl_list.Inactive },
        -- basic.file_name_inactive,
        { b_components.divider, hl_list.Inactive },
        -- { b_components.line_col, hl_list.Inactive },
        -- { b_components.progress, hl_list.Inactive },
    },
}

local setup = function()
    windline.setup({
        colors_name = function(colors)
            -- print(vim.inspect(colors))
            -- ADD MORE COLOR HERE ----
            return colors
        end,
        statuslines = {
            default,
            quickfix,
            explorer,
            terminal
        },
    })
end

setup()
-- require('wlsample.vscode')
