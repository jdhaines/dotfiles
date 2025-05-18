-- High-Performance color highlighter
return {
    'norcalli/nvim-colorizer.lua',
    config = function()
        require('colorizer').setup()
    end,
}
