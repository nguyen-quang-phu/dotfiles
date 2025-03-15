return {
  {
    "neovim/nvim-lspconfig",
    dependencies = "netmute/ctags-lsp.nvim",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gr", false, desc = "References",            nowait = true },
        { "gR", false, desc = "References",            nowait = true },
        { "gI", false, desc = "Goto Implementation" },
        { "gy", false, desc = "Goto T[y]pe Definition" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = {
          format = function(diagnostic)
            if diagnostic.code == nil then
              return string.format("[%s]: %s", diagnostic.source, diagnostic.message)
            end

            return string.format("[%s]: %s (%s)", diagnostic.source, diagnostic.message, diagnostic.code)
          end,
        },
      },
      servers = {
        lua_ls = require("lsp.lua_ls"),
        cssmodules_ls = require("lsp.cssmodules_ls"),
        textlsp = require("lsp.textlsp"),
        golangci_lint_ls = {},
        emmet_language_server = {},
        sqls = {},
        harper_ls = {
          mason = false,
        },
        css_variables = {},
        bashls = {
          mason = false,
        },
        buf_ls = {},
        pyright = {
          mason = false,
        },
        protols = {},
        cssls = require("lsp.cssls"),
        phpactor = {},
        markdown_oxide = {},
        jsonls = {
          mason = false,
        },
        marksman = { enabled = false },
        texlab = {},
        volar = {
          mason = false,
          settings = {
            volar = {
              filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
            },
          },
        },
        stimulus_ls = {
          filetypes = { "html", "ruby", "eruby", "blade", "php", "slim" },

          settings = {
            stimulus_ls = {},
          },
        },
        gopls = require("lsp.gopls"),
        vtsls = require("lsp.vtsls"),
        tailwindcss = require("lsp.tailwindcss"),
        eslint = require("lsp.eslint"),
        solargraph = require("lsp.solargraph"),
        ansiblels = {
          mason = false,
        },
        ruby_lsp = {
          mason = false,
        },
        rubocop = {
          enabled = false,
          mason = false,
        },
        yamlls = require("lsp.yamlls"),
        nixd = {
          mason = false,
        },
        nil_ls = {
          mason = false,
        },
        angularls = {
          mason = false,
        },
        svelte = {
          mason = false,
        },
        kulala_ls = {},
        docker_compose_language_service = {
          mason = true,
        },
        dockerls = {
          mason = true,
        },
        graphql = {
          mason = true,
          cmd = { "npx", "graphql-language-service-cli", "server", "-m", "stream" },
        },
        -- ctags_lsp = {},
        typos_lsp = {
          mason = true,
        },
      },
    },
  },
  -- lazy.nvim
}
