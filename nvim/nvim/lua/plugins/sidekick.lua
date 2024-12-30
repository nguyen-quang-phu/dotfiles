return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        enabled = true,
        backend = "zellij", -- or "zellij"
      },
    },
  }
}
