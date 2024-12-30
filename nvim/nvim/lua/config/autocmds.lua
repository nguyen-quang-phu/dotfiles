-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  command = "set formatoptions-=c formatoptions-=r",
})

-- Add auto command for YAML files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.yml" },
  command = "setfiletype=yaml",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.slim" },
  command = "setlocal filetype=slim",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "justfile" },
  command = "setfiletype=make",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function()
    vim.diagnostic.config({ signs = false })
  end,
})

vim.api.nvim_create_autocmd("TabNew", {
  callback = function()
    vim.cmd("tabclose")
    vim.notify("Only one tab allowed!", vim.log.levels.WARN)
  end
})
