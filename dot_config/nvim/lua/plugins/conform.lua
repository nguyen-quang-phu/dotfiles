return {
  "stevearc/conform.nvim",
  keys = {
    { "<leader>cf", false },
    {
      -- Customize or remove this keymap to your liking
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer with comform.nvim",
    },
  },
  opts = {
    format = {
      timeout_ms = 30000,
    },
    formatters_by_ft = {
      ruby = { "rubocop" },
      eruby = { "erb_lint", "erb_formatter" },
    },
    formatters = {
      ---@type conform.FileFormatterConfig
      erb_lint = {
        meta = {
          url = "https://github.com/Shopify/erb-lint",
          description = "Format ERB files with speed and precision.",
        },
        command = "bundle",
        args = { "exec", "erblint", "--autocorrect", "$FILENAME" },
        stdin = false,
      },
      erb_formatter = {
        meta = {
          url = "https://github.com/nebulab/erb-formatter",
          description = "Format ERB files with speed and precision.",
        },
        command = "bundle",
        args = { "exec", "erb-format", "-w", "$FILENAME" },
        stdin = false,
      },
      rubocop = {
        command = "bundle",
        args = { "exec", "rubocop", "-A", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
