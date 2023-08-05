---@type MappingsTable
local M = {}
M.disabled = {
  n = {
    ["gr"] = "",
    ["<C-c>"] = "",
    ["K"] = "",
  },
  v = {
    ["gr"] = "",
  },
}
M.general = {
  n = {
    -- switch between windows
    ["<left>"] = { "<C-w>h", "window left" },
    ["<right>"] = { "<C-w>l", "window right" },
    ["<down>"] = { "<C-w>j", "window down" },
    ["<up>"] = { "<C-w>k", "window up" },
    ["<D-w>v"] = { "<C-w>v", "split vertical" },
    ["<D-w>s"] = { "<C-w>s", "split horizontal" },
    ["<D-w>o"] = { "<C-w>o", "only window" },
    ["<D-w>q"] = { "<C-w>q", "close window" },
    -- save
    ["<D-s>"] = { "<cmd> w <CR>", "save file" },
    ["<D-[>"] = { "<esc>", "ESC" },
    -- Copy all
    ["<D-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },
    ["<D-f>"] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr><cmd> w <CR>", " ", opts = { nowait = true } },
    ["<S-M-j>"] = { "<esc><cmd>copy .<cr>" },
    ["<S-M-k>"] = { "<esc><cmd>copy .-1<cr>" },
    ["<leader><CR>"] = { "<cmd>source ~/.config/nvim/lua/custom/init.lua<CR>" },
    ["gJ"]= {"<cmd>:SplitjoinJoin<cr>"},
    ["gS"]= {"<cmd>:SplitjoinSplit<cr>"},
  },
  i = {
    ["<D-v>"] = { "<c-r>+", " ", opts = { nowait = true } },
    ["<S-D-j>"] = { "<esc><cmd>copy .<cr>" },
  },
  c = {
    ["<D-v>"] = { "<c-r>+", " ", opts = { nowait = true } },
  },
}

M.hop = {
  plugin = true,
  n = {
    ["f"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        }
      end,
    },
    ["F"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        }
      end,
    },
    ["t"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
    },
    ["T"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
    },
    ["<leader>w"] = { "<cmd>HopWord<cr>" },
  },
}

M.comment = {
  plugin = true,
  -- toggle comment in both modes
  n = {
    ["<D-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },
  v = {
    ["<D-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
  i = {
    ["<D-/>"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "toggle comment" },
  },
}

-- more keybinds!
M.nvimtree = {
  n = {
    ["<D-b>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["<S-D-e>"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,
  n = {
    -- find
    ["<D-p>"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "find files" },
    ["<S-D-f>"] = { "<cmd>Telescope live_grep hidden=true no_ignore=true<cr>", "live grep" },
    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },
    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },
    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.nvterm = {
  plugin = true,
  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
  },
  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
    -- new

    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "new horizontal term",
    },
    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "new vertical term",
    },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },
  },
}

M.replace_with_register = {
  n = {
    ["gr"] = { "<Plug>ReplaceWithRegisterOperator", "ReplaceWithRegisterOperator" },
    ["grr"] = { "<Plug>ReplaceWithRegisterLine", "ReplaceWithRegisterLine" },
  },
  v = {
    ["gr"] = { "<Plug>ReplaceWithRegisterVisual", "ReplaceWithRegisterVisual" },
  },
}

M.nvterm = {
  plugin = true,
  t = {
    -- toggle in terminal mode
    ["<D-`>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
  },
  n = {
    -- toggle in normal mode
    ["<D-`>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
    -- new

    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "new horizontal term",
    },
    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "new vertical term",
    },
  },
}

M.lspsaga = {
  n = {
    ["gd"] = { "<Cmd>Lspsaga finder<CR>", "Lspsaga lsp_finder" },
    ["<D-.>"] = { "<Cmd>Lspsaga code_action<Cr>", "Lspsaga code_action" },
    ["<F2>"] = { "<Cmd>Lspsaga rename<CR>", "Lspsaga rename" },
  },
}

M.yanky = {
  n = {
    ["y"] = { "<Plug>(YankyYank)", "YankyYank" },
    ["p"] = { "<Plug>(YankyPutAfter)", "YankyPutAfter" },
    ["P"] = { "<Plug>(YankyPutBefore)", "YankyPutBefore" },
  },
}

-- M.ts_node_action = {
--   n = {
--     ["gs"] = { "<cmd>NodeAction<cr>", "Trigger Node Action" },
--   },
-- }

M.lazy_git = {
  n = {
    ["<leader>lg"] = { "<cmd>LazyGit<cr>", "LazyGit" },
  },
}

return M
