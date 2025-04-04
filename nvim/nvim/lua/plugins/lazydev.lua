return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      dependencies = {
        -- Manage libuv types with lazy. Plugin will never be loaded
        { "Bilal2453/luvit-meta", lazy = true },
      },
      library = {
        { path = "~/workspace/avante.nvim/lua", words = { "avante" } },
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
}
