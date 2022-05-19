local langs = {}

-- Markdown Preview
langs["ellisonleao/glow.nvim"] = {
    ft = {'markdown'},
    cmd = 'Glow',
    config = function ()
        vim.g.glow_binary_path = vim.env.HOME.."/.local/bin"
    end
}

return langs
