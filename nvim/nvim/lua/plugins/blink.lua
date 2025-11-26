return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    -- dependencies = "rafamadriz/friendly-snippets",
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      { "Kaiser-Yang/blink-cmp-avante" },
      -- ... Other dependencies
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        documentation = {
          auto_show = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
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
        default = { 'lsp', 'path' },
        providers= {
          snippets = {
            enabled = false;
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
        -- transform_items = function(_, items)
        --   -- return vim.tbl_filter(function(item)
        --   --   return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
        --   --     and item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
        --   -- end, items)
        -- end,
        per_filetype = {
          scss = {
            inherit_defaults = false,
            'lsp',
          },
        }
      },

    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
  },
}
