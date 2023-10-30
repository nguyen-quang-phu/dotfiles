-- TODO: Test
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "kana/vim-textobj-entire",
    lazy = false,
    dependencies = { { "kana/vim-textobj-user" } },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    event = "User AstroFile",
  },
  {
    "vim-scripts/ReplaceWithRegister",
    lazy = false,
  },
  -- ruby
  {
    "tpope/vim-rails",
    lazy = false,
    ft = "ruby",
  },
  {
    "noahfrederick/vim-laravel",
    lazy = false,
    dependencies = { { 'tpope/vim-dispatch','tpope/vim-projectionist', 'noahfrederick/vim-composer'} },
  },
  {
    "semanticart/ruby-code-actions.nvim",
  },
  {
    "bkad/CamelCaseMotion",
    lazy = false,
  },
  {
    "tpope/vim-abolish",
    lazy = false,
  },
  {
    "axelvc/template-string.nvim",
    opts = {},
    lazy = false,
  },
  {
    "AndrewRadev/switch.vim",
    lazy = false,
  },
  {
    "tpope/vim-rbenv",
    lazy = false,
  },
  {
    "vim-test/vim-test",
    lazy = false,
  },
  {
    "michaeljsmith/vim-indent-object",
    lazy = false,
  },
  {
    "cbochs/portal.nvim",
    cmd = "Portal",
    opts = {},
    keys = {
      { "<C-o>", "<cmd>Portal jumplist backward<cr>", desc = "Portal Jump backward" },
      { "<C-i>", "<cmd>Portal jumplist forward<cr>", desc = "Portal Jump forward" },
    },
  },  {
    "AndrewRadev/splitjoin.vim",
    lazy = false,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "suketa/nvim-dap-ruby", config = true },
  },
}
