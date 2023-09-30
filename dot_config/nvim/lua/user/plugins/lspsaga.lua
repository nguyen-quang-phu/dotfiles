return {
  "nvimdev/lspsaga.nvim",
  event = "BufRead",
  lazy = false,
  opts = {
    debug = true,
    finder = {
      max_height = 0.6,
      keys = {
        vsplit = 'v',
        edit = '<cr>'
      }
    },
    lightbulb = {
      enable = false,
      enable_in_insert = false,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
    },
  },
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter" },
    { "RRethy/nvim-treesitter-textsubjects" },
  },
}
