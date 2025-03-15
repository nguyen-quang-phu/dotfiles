return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    -- dependencies = "rafamadriz/friendly-snippets",

    version = "v0.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      signature = { enabled = true },
      keymap = { preset = "enter" },
      completion = {
        keyword = { range = "prefix" },
        accept = { auto_brackets = { enabled = false } },
        ghost_text = { enabled = false },
        list = { selection = { preselect = false, auto_insert = false } },
        menu = {
          auto_show = true,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
      sources = {
        default = {
          "lsp",
          -- "path",
          -- "snippets",
          -- "buffer",
        },
        providers = {
          lsp = {
            score_offset = 150,
          },
        },
      },
      -- enable completion sources
      -- 'path' for file system paths
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
  },
}
