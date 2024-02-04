return function()
  -- create an augroup to easily manage autocommands
  vim.api.nvim_create_augroup("autohidetabline", { clear = true })
  -- create a new autocmd on the "User" event
  vim.api.nvim_create_autocmd("User", {
    desc = "Hide tabline when only one buffer and one tab", -- nice description
    -- triggered when vim.t.bufs is updated
    pattern = "AstroBufsUpdated", -- the pattern is the name of our User autocommand events
    group = "autohidetabline", -- add the autocmd to the newly created augroup
    callback = function()
      -- if there is more than one buffer in the tab, show the tabline
      -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
      local new_showtabline = #vim.t.bufs > 1 and 2 or 1
      -- check if the new value is the same as the current value
      if new_showtabline ~= vim.opt.showtabline:get() then
        -- if it is different, then set the new `showtabline` value
        vim.opt.showtabline = new_showtabline
      end
    end,
  })

  vim.api.nvim_create_autocmd(
    "BufEnter",
    { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } end }
  )

  -- Set up custom filetypes
  -- vim.filetype.add {
  --   extension = {
  --     foo = "fooscript",
  --   },
  --   filename = {
  --     ["Foofile"] = "fooscript",
  --   },
  --   pattern = {
  --     ["~/%.config/foo/.*"] = "fooscript",
  --   },
  -- }
end
