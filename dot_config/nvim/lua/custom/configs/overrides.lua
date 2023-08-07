local M = {}

M.treesitter = {
  ensure_installed = {
    "html",
    "css",
    "javascript",
    "c",
    "markdown",
    "markdown_inline",
    "astro",
    "glimmer",
    "graphql",
    "lua",
    "php",
    "python",
    "scss",
    "svelte",
    "tsx",
    "twig",
    "typescript",
    "vim",
    "vue",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
  endwise = {
    enable = true,
  },
  -- rainbow = {
  --   enable = true,
  --   -- disable = { 'jsx', 'cpp' },
  --   query = "rainbow-parens",
  --   strategy = require("ts-rainbow").strategy.global,
  -- },
  textsubjects = {
    enable = true,
    prev_selection = ",", -- (Optional) keymap to select the previous selection
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
      ["i;"] = "textsubjects-container-inner",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    autotag = {
      enable = true,
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",

    -- ruby
    "solargraph",
    -- python
    "pyright",
    "ruff",
    "mypy",
    "black"
  },
}

-- git support in nvimtree
M.nvimtree = {
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
  view = {
    adaptive_size = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

-- cmp
M.cmp = {
  mapping = {
    ["<up>"] = require("cmp").mapping.select_prev_item(),
    ["<down>"] = require("cmp").mapping.select_next_item(),
    ["<Tab>"] = vim.NIL,
  },
}

M.gitsigns = {
  current_line_blame = true,
}

return M
