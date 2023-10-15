return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    -- local null_ls = require "null-ls"
    local diagnostics = require("null-ls").builtins.diagnostics
    local formatting = require("null-ls").builtins.formatting
    local code_actions = require("null-ls").builtins.code_actions
    local methods = require("null-ls").methods
    local ruby_code_actions = require "ruby-code-actions"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
      -- refactor
      require("typescript.extensions.null-ls.code-actions"),
      code_actions.refactoring,

      -- check spell
      diagnostics.cspell.with {
        diagnostics_format = "[cspell] #{m}\n(#{c})",
        methods = methods.DIAGNOSTICS_ON_SAVE,
      },
      code_actions.cspell,

      -- js,ts
      code_actions.eslint_d,
      formatting.prettierd,
      formatting.eslint_d,
      diagnostics.eslint_d.with {
        diagnostics_format = "[eslint] #{m}\n(#{c})",
        filetypes = { "js", "jsx", "ts", "tsx" },
        methods = methods.DIAGNOSTICS_ON_SAVE,
      },

      -- ruby
      -- diagnostics.rubocop.with {
      --   command = "bundle",
      --   args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args),
      --
      --   diagnostics_format = "[rubocop] #{m}\n(#{c})",
      --   methods = methods.DIAGNOSTICS_ON_SAVE,
      -- },
      -- formatting.rubocop.with {
      --   command = "bundle",
      --   args = vim.list_extend({ "exec", "rubocop", "--auto-correct" }, formatting.rubocop._opts.args),
      -- },
      ruby_code_actions.insert_frozen_string_literal,
      ruby_code_actions.autocorrect_with_rubocop,

      --lua
      formatting.stylua,

      -- go
      diagnostics.golangci_lint.with {
        diagnostics_format = "[golangci_lint] #{m}\n(#{c})",
        methods = methods.DIAGNOSTICS_ON_SAVE,
      },
      diagnostics.gospel.with {
        diagnostics_format = "[gospel] #{m}\n(#{c})",
        methods = methods.DIAGNOSTICS_ON_SAVE,
      },
      formatting.gofumpt,
      formatting.goimports_reviser,
      formatting.golines,
      -- python
      diagnostics.mypy.with {
        diagnostics_format = "[mypy] #{m}\n(#{c})",
        methods = methods.DIAGNOSTICS_ON_SAVE,
        extra_args = function()
          local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_DEFAULT_ENV" or "./venv"
          print(virtual)
          return { "--python-executable", virtual .. "/bin/python3" }
        end,
      },
      diagnostics.ruff.with {
        diagnostics_format = "[ruff] #{m}\n(#{c})",
        methods = methods.DIAGNOSTICS_ON_SAVE,
      },
      formatting.black,
      formatting.ruff,
    }
    return config -- return final config table
  end,
}
