-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.title = true
vim.opt.backup = false
vim.opt.showcmd = true
--vim.opt.wildignore:append({ "*/node_modules/*" })
-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.g.autoformat = false

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
--vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
