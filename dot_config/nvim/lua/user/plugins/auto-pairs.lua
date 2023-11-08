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
