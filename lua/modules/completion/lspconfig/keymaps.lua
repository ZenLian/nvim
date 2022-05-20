local M = {}

local wk = require('which-key')
local util = require('core.util')

local leader = {
    l = {
        name = "language",
        f = { vim.lsp.buf.formatting, "File format" },
        a = { vim.lsp.buf.code_action, "Code action" },
        r = { vim.lsp.buf.rename, "Rename" },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
    },
    x = {
        s = { "<cmd>Telescope document_diagnostics<cr>", "Search Document Diagnostics" },
        w = { "<cmd>Telescope workspace_diagnostics<cr>", "Workspace Diagnostics" },
    }
}

local leader_visual = {
    l = {
        name = "language",
        f = { vim.lsp.buf.range_formatting, "Range Format" },
        a = { vim.lsp.buf.range_code_action, "Code action" },
    }
}

local g = {
    name = "+goto",
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
    R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
    d = { "<Cmd>Telescope lsp_definitions <CR>", "Goto Definition" },
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
}

function M.on_attach(client, bufnr)

    local opts = { buffer = bufnr }
    util.map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    util.map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    util.map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    util.map("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
    util.map("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

    wk.register(leader, { buffer = bufnr, prefix = "<Leader>" })
    wk.register(leader_visual, { buffer = bufnr, prefix = "<Leader>", mode = "v" })
    wk.register(g, { buffer = bufnr, prefix = "g" })
end

return M
