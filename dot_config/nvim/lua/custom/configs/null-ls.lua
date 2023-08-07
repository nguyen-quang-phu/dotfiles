local present, null_ls = pcall(require, "null-ls")
local ruby_code_actions = require "ruby-code-actions"
if not present then
  return
end

local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local code_actions = require("null-ls").builtins.code_actions
local methods = require("null-ls").methods

local sources = {
  -- refactor
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
  diagnostics.rubocop.with {
    command = "bundle",
    args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),

    diagnostics_format = "[rubocop] #{m}\n(#{c})",
    methods = methods.DIAGNOSTICS_ON_SAVE,
  },
  formatting.rubocop.with {
    command = "bundle",
    args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args),
  },
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
  -- python
  diagnostics.mypy.with {
    diagnostics_format = "[mypy] #{m}\n(#{c})",
    methods = methods.DIAGNOSTICS_ON_SAVE,
  },
  diagnostics.ruff.with {
      diagnostics_format = "[ruff] #{m}\n(#{c})",
      methods = methods.DIAGNOSTICS_ON_SAVE,
    },
  formatting.black,
  formatting.ruff

}

null_ls.setup {
  debug = true,
  sources = sources,
  diagnostic_config = {
    signs = false,
  },
}
-- require("null-ls").register {
--   name = "more_actions",
--   method = { require("null-ls").methods.CODE_ACTION },
--   filetypes = { "_all" },
--   generator = {
--     fn = require("ts-node-action").available_actions,
--   },
-- }
