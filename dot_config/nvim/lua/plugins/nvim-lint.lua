return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      ["*"] = { "codespell" },
      lua = { "luacheck" },
      ruby = { "rubocop" },
      eruby = { "erb_lint" },
      -- javascript = { "eslint" },
      -- javascriptreact = { "eslint" },
      -- typescript = { "eslint" },
      -- typescriptreact = { "eslint" },
      -- vue = { "eslint" },
    },
  },
}
