return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "RRethy/nvim-treesitter-endwise" },
  opts = {
    ensure_installed = { "kdl", "markdown", "markdown_inline" },
    highlight = {
      enable = true,
    },
    endwise = { enable = true },
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
    },
  },
}
