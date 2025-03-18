return {
  {
    "potamides/pantran.nvim",
    opts = {
      command = {
        -- default_mode = "hover",
        default_source = "en",
        default_target = "vi",
      },
      default_engine = "google",
      ui = {},
      window = {
        window_config = {
          relative = "editor",
          border = "single",
        },
      },
      engines = {
        google = {
          -- Default languages can be defined on a per engine basis. In this case
          -- `:lua require("pantran.async").run(function()
          -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
          -- can be used to list available language identifiers.
          default_source = "en",
          default_target = "en",
        },
      },
      controls = {
        mappings = {
          edit = {
            n = {
              ["<Esc>"] = false,
            },
          },
        },
      },
    },
  },
  -- {
  --   "uga-rosa/translate.nvim",
  --   opts = {
  --     default = {
  --       command = "google",
  --       output = "floating", },
  --     preset = {
  --       output = {
  --         floating = {
  --           relative = "cursor",
  --           style = "minimal",
  --           width = nil,
  --           height = nil,
  --           row = 1,
  --           col = 1,
  --           border = "rounded",
  --           filetype = "translate",
  --           zindex = 50,
  --           anchor = "ne",
  --         },
  --       },
  --     },
  --   },
  -- },
}
