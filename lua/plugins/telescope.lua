local wk = require("which-key")
wk.register({
    ["<leader>fc"] = { name = "+code" },
})
return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            "gh",
            function()
                require('telescope.builtin').lsp_incoming_calls()
            end,
            desc = "lsp_incoming_calls"
        },
    }
}
