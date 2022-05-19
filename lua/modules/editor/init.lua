local editor = {}

editor["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    run = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    config = function()
        require('modules.editor.treesitter')
    end
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
    opt = true,
    after = "nvim-treesitter",
}
-- 代码块高亮很碍眼，当前单词高亮还行，以后需要再配置
--editor["nvim-treesitter/nvim-treesitter-refactor"] = {
--    opt = true,
--    after = "nvim-treesitter"
--}
editor["lewis6991/nvim-treesitter-context"] = {
    opt = true,
    after = "nvim-treesitter",
}

editor["p00f/nvim-ts-rainbow"] = {
    opt = true,
    after = "nvim-treesitter",
}

editor["numToStr/Comment.nvim"] = {
    config = function()
        require("Comment").setup {
            -- ignore blank lines
            ignore = '^(%s*)$'
        }
    end
}
editor["mfussenegger/nvim-treehopper"] = {
    opt = true,
    after = "nvim-treesitter",
    config = function()
        require('modules.editor.treehopper')
    end
}

editor["ur4ltz/surround.nvim"] = {
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("surround").setup { mappings_style = "surround" }
    end
}

editor["ggandor/lightspeed.nvim"] = {
    event = { "BufRead", "BufNewFile" },
    config = function()
        require('modules.editor.lightspeed')
    end
}

editor["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = { "BufRead", "BufNewFile" },
    requires = { "nvim-lua/plenary.nvim", opt = false },
    config = function()
        require('modules.editor.gitsigns')
    end
}

return editor
