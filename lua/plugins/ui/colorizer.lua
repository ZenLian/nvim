require('colorizer').setup(
    {
        '*',
        -- '!NvimTree', -- exclude filetypes
        css = {
            names = true,
            rgb_fb = true, -- rgb(...)
        },
    },
    {
    names = false
}
)
