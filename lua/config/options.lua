-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- vim.lsp.set_log_level('debug')
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.title = true
vim.opt.backup = false
vim.opt.showcmd = true
--vim.opt.wildignore:append({ "*/node_modules/*" })
-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.g.autoformat = false

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = false -- Pressing the TAB key will insert spaces instead of a TAB character
--vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.g.snacks_animate = false
vim.opt.spelllang={"en_gb","fr"}
vim.opt.spell = false


local no_ci = os.getenv("NO_CI")
local no_lsp = os.getenv("NO_LSP")
vim.g.lsp_enabled = (no_lsp == nil or no_lsp ~= "true")
vim.g.ci_enabled = vim.g.lsp_enabled and (no_ci == nil or no_ci ~= "true")
vim.notify("LSP extensions enabled " .. tostring(vim.g.ci_enabled), vim.log.levels.INFO)
