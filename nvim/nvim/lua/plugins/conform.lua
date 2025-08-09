return {
  "stevearc/conform.nvim",
  enabled = true,
  keys = {
    { "<leader>cf", false },
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = "v",
      desc = "Format buffer with comform.nvim",
    },
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    default_format_opts = {
      timeout_ms = 30000,
    },
    formatters_by_ft = {
      json = { "jq" },
      sql = { "sqlfluff" },
      nix = { "alejandra" },
      proto = { "clang-format" },
      go = { "gofumpt", "goimports-reviser", "golines" },
      ruby = { "rubocop" },
      slim = { "rubocop" },
      eruby = { "erb_lint", "erb_formatter" },
      javascript = { "eslint"},
      javascriptreact = { "eslint" },
      typescript = { "eslint"},
      typescriptreact = { "eslint"},
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
