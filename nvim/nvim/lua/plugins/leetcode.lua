return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  -- cmd = "Leet",
  opts = {
    lang = "golang",
    picker = { provider = "telescope" },
    ---@type lc.storage
    storage = {
      home ="/home/keynold/.config/nvim/leetcode"
    },
    -- configuration goes here
    injector = { ---@type table<lc.lang, lc.inject>
      ["golang"] = {
        before = "package leetcode",
        after="// Keynold"
      },
    }
  },
}
