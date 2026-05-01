-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "tmux.conf", ".tmux.conf" },
  callback = function()
    vim.lsp.start({
      name = "tmux",
      cmd = { "tmux-language-server" }
    })
  end,
})


