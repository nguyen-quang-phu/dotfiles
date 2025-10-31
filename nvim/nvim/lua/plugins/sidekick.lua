return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      mux = {
        enabled = false,
        backend = "zellij", -- or "zellij"
      },
    },
  }
}
