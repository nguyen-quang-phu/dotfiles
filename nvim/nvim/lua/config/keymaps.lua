-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>ca")
vim.keymap.del("n", "<leader>cf")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gra")
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true })

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>gR", "<cmd>Telescope lsp_references<cr>", opts)
vim.api.nvim_set_keymap("n", "<Leader>tv", "<cmd>Pantran source=en target=vi<cr>", opts)
-- vim.keymap.set("n", "<Leader>e", function()
--   require("oil").toggle_float()
-- end, opts)
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

vim.keymap.set("n", "<leader>fw", function()
  require("snacks").picker.grep({ regex = false })
end, {})

vim.keymap.set("n", "<leader>fw", function()
  require("snacks").picker.grep({ regex = false, hidden = true, ignored = true })
end, {})
