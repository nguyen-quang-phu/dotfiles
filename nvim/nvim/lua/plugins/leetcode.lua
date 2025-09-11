return {
  {
    "3rd/image.nvim",
    config = function()
      require("image").setup({
        backend = "kitty", -- hoặc "ueberzug", "wezterm"
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = 50,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs" },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  {
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
      "3rd/image.nvim"
    },
    -- cmd = "Leet",
    opts = {
      lang = "golang",
      picker = { provider = "snacks-picker" },
      ---@type lc.storage
      storage = {
        home ="/Users/dev/Code/keynold/leetcode"
      },
      -- configuration goes here
      injector = { ---@type table<lc.lang, lc.inject>
        ["golang"] = {
          before = "package leetcode",
          after="// Keynold"
        },
      },
      image_support = true
    },
  }
}
