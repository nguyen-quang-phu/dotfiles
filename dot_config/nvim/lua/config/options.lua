-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false

vim.opt.showtabline = 0
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.swapfile = false

vim.filetype.add({
  extension = {
    yml = 'yaml'
  }
})
