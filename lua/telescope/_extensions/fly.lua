local ok, telescope = pcall(require, 'telescope')

if not ok then
    error 'Install nvim-telescope/telescope.nvim to use fly-query.nvim.'
end

local query = require 'telescope._extensions.fly.picker'

return telescope.register_extension {
    setup = function(opts, _)
        opts = vim.tbl_extend('force', default_opts, opts)
    end,
    exports = {
        fly_query = query,
    },
}
