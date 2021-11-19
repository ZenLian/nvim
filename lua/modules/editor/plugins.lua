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
editor["romgrk/nvim-treesitter-context"] = {
    opt = true,
    after = "nvim-treesitter"
}

return editor
