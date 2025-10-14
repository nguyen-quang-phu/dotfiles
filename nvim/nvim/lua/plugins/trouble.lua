return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  opts = {
    {
      modes = {
        diagnostics = {
          auto_open = true,
        },
      },
    },
    auto_close = true,
  },
}
