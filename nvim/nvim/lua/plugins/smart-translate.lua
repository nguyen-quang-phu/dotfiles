return {
  {
    "askfiy/smart-translate.nvim",
    cmd = { "Translate" },
    dependencies = {
      "askfiy/http.nvim", -- a wrapper implementation of the Python aiohttp library that uses CURL to send requests.
    },
    config = function()
      require("smart-translate").setup({
        default = {
          cmds = {
            source = "auto",
            target = "vi",
            handle = "float",
            engine = "google",
          },
          cache = true,
        },
      })
    end,
  },
}
