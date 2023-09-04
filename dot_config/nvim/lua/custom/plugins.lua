local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-endwise",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", "vendor", ".history", ".git", "tags", ".tags", "tmp", "log", "dist" },
        mappings = {
          i = {
            ["<esc>"] = function(...)
              require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = true,
  },
  {
    "nvimdev/lspsaga.nvim",
    opts = overrides.lspsaga,
    init = require("core.utils").load_mappings "lspsaga",
    event = "BufRead",
    lazy = false,
    config = function()
      require "custom.configs.lspsaga"
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
      { "RRethy/nvim-treesitter-textsubjects" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },
  {
    "vim-scripts/ReplaceWithRegister",
    lazy = false,
  },
  {
    "tpope/vim-rails",
    lazy = false,
    ft = "ruby",
  },
  {
    "gbprod/yanky.nvim",
    init = require("core.utils").load_mappings "yanky",
    event = "BufReadPost",
    config = function()
      require "custom.configs.yanky"
    end,
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require "custom.configs.dressing"
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    config = function()
      require("auto-save").setup {}
    end,
  },
  -- better increase/descrease
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<D-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = "Increment",
      },
      {
        "<D-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = "Decrement",
      },
    },
    config = function()
      require "custom.configs.dial"
    end,
  },
  {
    "michaeljsmith/vim-indent-object",
    lazy = false,
  },
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {}
    end,
  },
  {
    "semanticart/ruby-code-actions.nvim",
  },
  {
    "kana/vim-textobj-entire",
    lazy = false,
    dependencies = { { "kana/vim-textobj-user" } },
  },
  {
    "kdheepak/lazygit.nvim",
    init = require("core.utils").load_mappings "lazy_git",
    lazy = false,
  },
  {
    "tpope/vim-repeat",
    lazy = false,
  },
  {
    "AndrewRadev/switch.vim",
    lazy = false,
  },
  -- {
  --   "ckolkey/ts-node-action",
  --   dependencies = { "nvim-treesitter" },
  --   opts = {},
  --   lazy = false,
  -- },
  {
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
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
  {
    "bkad/CamelCaseMotion",
    lazy = false,
  },
  {
    "tpope/vim-abolish",
    lazy = false,
  },
  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      require("mini.move").setup {}
      require("mini.cursorword").setup {}
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    config = function()
      vim.g.VM_maps["Find Under"] = "<D-d>"
      vim.g.VM_maps["Find Subword Under"] = "<D-d>"
    end,
  },
  {
    "phaazon/hop.nvim",
    lazy = false,
    keys = {
      {
        "<leader>w",
        "<cmd>HopWord<cr>",
      },
    },
    config = function()
      local hop = require "hop"
      hop.setup {
        keys = "etovxqpdygfblzhckisuran",
      }
      local directions = require("hop.hint").HintDirection
      vim.keymap.set("", "f", function()
        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
      end, { remap = true })
      vim.keymap.set("", "t", function()
        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
      end, { remap = true })
      vim.keymap.set("", "T", function()
        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
      end, { remap = true })
    end,
    init = require("core.utils").load_mappings "hop",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    init = require("core.utils").load_mappings "comment",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", lazy = false },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup {
        keymaps = {
          close = { "" },
          toggle_preview = "gh",
        },
      }
    end,
    lazy = false,
    keys = {
      {
        "<S-D-o>",
        "<cmd>SymbolsOutline<cr>",
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
    config = function()
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      }
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "ray-x/lsp_signature.nvim",
    opts = {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded",
      },
    },
    lazy = false,
  },
  {
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup()
    end,
    lazy = false,
  },
  {
    "vim-test/vim-test",
    lazy = false,
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
  },
  {
    "0x00-ketsu/markdown-preview.nvim",
    ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
    config = function()
      require("markdown-preview").setup {}
    end,
  },
  {
    "tpope/vim-projectionist",
    lazy = false,
    ft = { "javascript", "typescript" },
  },
  {
    "editorconfig/editorconfig-vim",
    lazy = false,
  },
  {
    "vim-scripts/PreserveNoEOL",
    lazy = false,
  },
  {
    "AndrewRadev/rails_extra.vim",
    lazy = false,
  },
  {
    "AndrewRadev/splitjoin.vim",
    lazy = false,
  },
  {
    "Exafunction/codeium.vim",
    lazy = false,
  },
  {
    "nvimdev/hlsearch.nvim",
    event = "BufRead",
    config = function()
      require("hlsearch").setup()
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    lazy = false,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    lazy = false,
  },
  {
    "chentoast/marks.nvim",
    lazy = false,
    config = function()
      require("marks").setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      }
    end,
  },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {},
  --   config = function()
  --     require("hardtime").setup {}
  --   end,
  --   lazy = false,
  --   keys = {
  --     { "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"' },
  --     { "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"' },
  --   },
  -- },
}

return plugins
