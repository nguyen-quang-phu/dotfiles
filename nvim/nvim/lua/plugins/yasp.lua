return {
  {
    "DimitrisDimitropoulos/yasp.nvim",
    -- lazy loading is not required, since it is handled internally
    lazy = false,
    -- if you persist on lazy loading you must call the setup function on InsertEnter
    -- event = 'InsertEnter',
    opts = {
      -- default, change to false for special completion frameworks
      -- long_desc = true,
      -- default, change to true mainly for debugging
      -- prose = false,
      -- default, the time to wait before starting a new server in milliseconds, highly suggested to keep it
      -- debounce = 750,
      -- default, global triggerChars to fire lsp completion
      -- trigger_chars = {
      --   ['*'] = { '{', '(', '[', ' ', '.', ':', ',' },
      --   -- append them per filetype in such style
      --   -- ['lua'] = { '.', ':' },
      -- },

      -- 💀 WARNING: the following must be provided by the user
      -- the paths to the package.json files, no default given, must be provided
      paths = {
        "/Users/dev/dotfiles/nvim/nvim/snippets/package.json",
      },
      descs = { "keynold snippets" },
    },
  },
}
