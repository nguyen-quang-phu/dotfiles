-- set vim options here (vim.<first_key>.<second_key> = value)

-- Helper function for transparency formatting
local alpha = function() return string.format("%x", math.floor(255 * vim.g.transparency or 0.8)) end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
return {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap
    showtabline = 0,
    swapfile = false,
    eof = true,
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = false, -- disable notifications when toggling UI elements
    resession_enabled = false, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
    neovide_transparency = 0.24,
    neovide_transparency_point = 0.8,
    neovide_cursor_antialiasing = false,
    neovide_cursor_animation_length = 0,
    neovide_background_color = "1e1e1e",
    neovide_remember_window_size = true,
    -- neovide_input_macos_alt_is_meta = true,
    neovide_hide_mouse_when_typing = true,
    splitjoin_split_mapping = "",
    splitjoin_join_mapping = "",
    camelcasemotion_key = "<leader>",
    ["test#strategy"] = "mood-term",
    ["test#neovim#start_normal"] = true,
    ruby_debugger = "binding.pry",
    spotify_token = "ZjkyNzMzM2RjOWU1NDRiZjhiOGQ4Y2NhMDE2YjJlMWE6YzNkYTZiODEwMjEzNGNjYzkwMTdjOGIwZjY0YWI4MjQ="
    -- neovide_transparency = 0.0,
    -- transparency = 0.8,
    -- neovide_background_color = "#0f1117" .. alpha(),
  },

}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
