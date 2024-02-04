return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.vscode-nvim" },

  -- { import = "astrocommunity.completion.codeium-vim" },
  { import = "astrocommunity.completion.cmp-cmdline" },

  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.typescript" },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "tsserver", "eslint" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("eslint_fix_creator", { clear = true }),
        desc = "Create autocommand in buffers where eslint attaches",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              desc = "Fix all eslint errors",
              buffer = args.buf,
              group = vim.api.nvim_create_augroup(("eslint_fix_%d"):format(args.buf), { clear = true }),
              callback = function()
                -- if vim.fn.exists ":EslintFixAll" > 0 then vim.cmd.EslintFixAll() end
              end,
            })
          end
        end,
      })
    end,
  },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.php" },
  -- { import = "astrocommunity.pack.ruby" },

  { import = "astrocommunity.editing-support.auto-save-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.hypersonic-nvim" },
  { import = "astrocommunity.editing-support.comment-box-nvim" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  -- { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },

  -- { import = "astrocommunity.workflow.hardtime-nvim" },

  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.motion.tabout-nvim" },
  -- { import = "astrocommunity.motion.mini-bracketed" },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.comment.mini-comment" },
  {
    "echasnovski/mini.comment",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  { import = "astrocommunity.syntax.vim-easy-align" },
  -- { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  -- { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
}
