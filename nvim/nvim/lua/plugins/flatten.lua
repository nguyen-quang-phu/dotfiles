return {
  {
    "willothy/flatten.nvim",
    -- or pass configuration with
    opts = {
      window = {
        open = "current",
      },
      integrations = {
        kitty = true,
      },
    },
    config = function(_, opts)
      require("flatten").setup(opts)
    end,
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
}
