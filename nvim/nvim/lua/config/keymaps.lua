-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

vim.keymap.del("n", "<leader>l")
-- vim.keymap.del("n", "<leader>ca")
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

vim.keymap.set("n", "=ig", function()
  vim.cmd("normal! mzgg=G`z")
end, { noremap = true, silent = true })

-- vim.keymap.set("n", "=ig", "mz=ig`z", { noremap = true })

-- vim.keymap.set("n", "<leader>fw", function()
--   require("snacks").picker.grep({ regex = false })
-- end, {})
--
-- vim.keymap.set("n", "<leader>fw", function()
--   require("snacks").picker.grep({ regex = false, hidden = true, ignored = true })
-- end, {})

-- vim.keymap.set('n', 'gd', function()
--   -- Jump from an i18n key usage to its definition
--   if require('i18n').i18n_definition() then
--     return
--   end
--   -- Jump from current i18n definition to the next locale's definition, following the order in locales
--   if require('i18n').i18n_definition_next_locale() then
--     return
--   end
--   -- Fall back to LSP definition
--   vim.lsp.buf.definition()
-- end, { desc = 'i18n or LSP definition' })
