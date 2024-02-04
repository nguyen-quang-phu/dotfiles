return {
  "windwp/nvim-autopairs",
  opts = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)

    -- setup cmp for autopairs
    local cmp = require "cmp"
    local handlers = require "nvim-autopairs.completion.handlers"
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local npairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"

    npairs.add_rules {
      Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
      end),
      Rule("( ", " )")
        :with_pair(function() return false end)
        :with_move(function(opts) return opts.prev_char:match ".%)" ~= nil end)
        :use_key ")",
      Rule("{ ", " }")
        :with_pair(function() return false end)
        :with_move(function(opts) return opts.prev_char:match ".%}" ~= nil end)
        :use_key "}",
      Rule("[ ", " ]")
        :with_pair(function() return false end)
        :with_move(function(opts) return opts.prev_char:match ".%]" ~= nil end)
        :use_key "]",
    }
    require("cmp").event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done {
        filetypes = {
          ["*"] = {
            ["("] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers["*"],
            },
          },
          ruby = false,
        },
      }
    )
  end,
}
