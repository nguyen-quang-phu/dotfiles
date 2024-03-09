-- TODO: Test
return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "User AstroFile",
  },
  -- ruby
  -- {
  --   "noahfrederick/vim-laravel",
  --   lazy = false,
  --   dependencies = { { "tpope/vim-dispatch", "tpope/vim-projectionist", "noahfrederick/vim-composer" } },
  -- },
  {
    "tpope/vim-abolish",
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
    "cbochs/portal.nvim",
    cmd = "Portal",
    opts = {},
    keys = {
      { "<C-o>", "<cmd>Portal jumplist backward<cr>", desc = "Portal Jump backward" },
      { "<C-i>", "<cmd>Portal jumplist forward<cr>", desc = "Portal Jump forward" },
    },
  },
  {
    "AndrewRadev/splitjoin.vim",
    lazy = false,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {
      input = {
        min_width = { 60, 0.9 },
      },
      select = {
        -- telescope = require('telescope.themes').get_ivy({...})
        --     telescope = require('telescope.themes').get_dropdown({ layout_config = { height = 15, width = 90 } }), }
        --     })
      },
    },
  },
  { "otavioschwanck/new-file-template.nvim", opts = {}, lazy = false },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      lang = "golang",
      -- configuration goes here
    },
  },
  { "beloglazov/vim-textobj-quotes", lazy = false, dependencies = { "kana/vim-textobj-user" } },
  { "AndrewRadev/rails_extra.vim", lazy = false },
  { "posva/vim-vue", lazy = false },
  -- lazy.nvim
}
