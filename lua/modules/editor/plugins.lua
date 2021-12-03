local editor = {}

editor["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    run = ":TSUpdate",
    event = {"BufRead", "BufNewFile"}
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
    opt = true,
    after = "nvim-treesitter"
}
-- 代码块高亮很碍眼，当前单词高亮还行，以后需要再配置
--editor["nvim-treesitter/nvim-treesitter-refactor"] = {
--    opt = true,
--    after = "nvim-treesitter"
--}
editor["romgrk/nvim-treesitter-context"] = {
    opt = true,
    after = "nvim-treesitter"
}
editor["p00f/nvim-ts-rainbow"] = {
    opt = true,
    after = "nvim-treesitter",
}
editor["terrortylor/nvim-comment"] = {
    config = function()
        require("nvim_comment").setup()
    end
}
editor["mfussenegger/nvim-treehopper"] = {
    opt = true,
    after = "nvim-treesitter"
}

editor["blackCauldron7/surround.nvim"] = {
    config = function()
        require("surround").setup {mappings_style = "surround"}
    end
}

editor["ggandor/lightspeed.nvim"] = {}

editor["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = {"BufRead", "BufNewFile"},
    requires = {"nvim-lua/plenary.nvim", opt = false}
}

return editor
