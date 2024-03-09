return function()
  -- create an augroup to easily manage autocommands
  -- vim.api.nvim_create_augroup("autohidetabline", { clear = true })
  -- -- create a new autocmd on the "User" event
  -- vim.api.nvim_create_autocmd("User", {
  --   desc = "Hide tabline when only one buffer and one tab", -- nice description
  --   -- triggered when vim.t.bufs is updated
  --   pattern = "AstroBufsUpdated", -- the pattern is the name of our User autocommand events
  --   group = "autohidetabline", -- add the autocmd to the newly created augroup
  --   callback = function()
  --     -- if there is more than one buffer in the tab, show the tabline
  --     -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
  --     local new_showtabline = #vim.t.bufs > 1 and 2 or 1
  --     -- check if the new value is the same as the current value
  --     if new_showtabline ~= vim.opt.showtabline:get() then
  --       -- if it is different, then set the new `showtabline` value
  --       vim.opt.showtabline = new_showtabline
  --     end
  --   end,
  -- })
  vim.api.nvim_create_autocmd(
    "BufEnter",
    { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } end }
  )
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
      local n_lines = vim.api.nvim_buf_line_count(0)
      local last_nonblank = vim.fn.prevnonblank(n_lines)
      if last_nonblank < n_lines then vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, { "" }) end
    end,
  })

  vim.cmd [[
    function TermStrategy(cmd)
      lua require("tmux-awesome-manager").execute_command({ cmd = vim.api.nvim_eval("a:cmd"), name = "Tests...", open_as = 'pane', size = '25%'})
    endfunction
     function AddDebugger()
      let buftype = getbufvar('', '&filetype', 'ERROR')

      if buftype == "ruby"
        execute "norm O" . g:ruby_debugger
      endif

      if buftype == "eruby"
        execute "norm O<% " . g:ruby_debugger . " %>"
      endif

      if buftype == "javascript" || buftype == "javascriptreact" || buftype == "typescript" || buftype == "typescriptreact"
        echo "j = down. k = up: "
        let direction = nr2char(getchar())

        execute 'norm 0\"dY'

        call setreg("d", substitute(getreg("d"), "'", "\\\\'", "g"))

        if direction == "j"
          execute "norm! oconsole.log('DEBUGGER', '\<esc>\"dpa', );\<esc>h"
          execute "startinsert"
        elseif direction == "k"
          execute "norm! Oconsole.log('DEBUGGER', '\<esc>\"dpa', );\<esc>h"
          execute "startinsert"
        else
          lua require('vim-notify')('Wrong Direction!', 'error', { title = 'mooD' })
        end
      else
        write
        execute "stopinsert"
      endif
    endfunction

    function ClearDebugger()
      let buftype = getbufvar('', '&filetype', 'ERROR')

      if buftype == "ruby"
        execute "%s/.*" . g:ruby_debugger . "\\n//gre"
      endif

      if buftype == "javascript" || buftype == "javascriptreact" || buftype == "typescript" || buftype == "typescriptreact"
        execute "%s/.*console.log(\\_.\\{-\\});\\n//gre"
      endif

      if buftype == "eruby"
        execute "%s/.*<% " . g:ruby_debugger . " %>\\n//gre"
      endif
      write
    endfunction
  ]]
  vim.cmd "let g:test#custom_strategies = {'mood-term': function('TermStrategy')}"

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
