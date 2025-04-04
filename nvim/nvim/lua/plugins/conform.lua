return {
  "stevearc/conform.nvim",
  enabled = true,
  keys = {
    -- { "<leader>cf", false },
    -- {
    --   -- Customize or remove this keymap to your liking
    --   "<leader>lf",
    --   function()
    --     require("conform").format({ async = true, lsp_fallback = true })
    --   end,
    --   mode = "",
    --   desc = "Format buffer with comform.nvim",
    -- },
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    default_format_opts = {
      timeout_ms = 30000,
    },
    formatters_by_ft = {
      json = { "jq" },
      nix = { "alejandra" },
      proto = { "clang-format" },
      go = { "gofumpt", "goimports-reviser", "golines" },
      ruby = { "rubocop" },
      slim = { "rubocop" },
      eruby = { "erb_lint", "erb_formatter" },
      javascript = { "eslint_d", "prettier" },
      javascriptreact = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
      typescriptreact = { "eslint_d", "prettier" },
      vue = { "eslint_d", "prettier" },
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
        args = {
          "exec",
          "rubocop",
          "-A",
          "-f",
          "json",
          "$FILENAME",
        },
        exit_codes = { 0, 1 },
        stdin = false,
      },
    },
  },
}
