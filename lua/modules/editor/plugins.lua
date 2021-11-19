local editor = {}

editor["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    run = ":TSUpdate",
    event = "VimEnter"
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

return editor
