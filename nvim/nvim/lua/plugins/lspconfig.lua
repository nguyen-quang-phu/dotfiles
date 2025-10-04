return {
  {
    "neovim/nvim-lspconfig",
    dependencies = "netmute/ctags-lsp.nvim",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gr", false, desc = "References",            nowait = true },
        -- { "gd", false, desc = "References",            nowait = true },
        { "gR", false, desc = "References",            nowait = true },
        -- { "gI", false, desc = "Goto Implementation" },
        { "gy", false, desc = "Goto T[y]pe Definition" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = false,
            },
          },
        },
      },
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
        -- ctags_lsp = {},
        angularls = { mason = false, },
        ansiblels = { mason = false, },
        bashls = require("lsp.bashls"),
        bufls = {},
        clangd = { mason = false, },
        css_variables = {},
        cssls = require("lsp.cssls"),
        cssmodules_ls = require("lsp.cssmodules_ls"),
        docker_compose_language_service = { mason = true, },
        dockerls = { mason = true, },
        emmet_language_server = {},
        eslint = require("lsp.eslint"),
        golangci_lint_ls = require("lsp.golangci_lint_ls"),
        gopls = require("lsp.gopls"),
        graphql = require("lsp.graphql"),
        harper_ls = require("lsp.harper_ls"),
        jdtls = { mason = false, },
        jsonls = require("lsp.jsonls"),
        kulala_ls = {},
        lua_ls = require("lsp.lua_ls"),
        markdown_oxide = {},
        marksman = { enabled = false },
        nginx_language_server = {},
        nil_ls = { mason = false, },
        nixd = { mason = false, },
        omnisharp = { mason = false, },
        oxlint = {},
        phpactor = {},
        -- protols = { mason = false, },
        pyright = { mason = false, },
        quick_lint_js = {},
        rubocop = { mason = false, },
        ruby_lsp = { mason = false, },
        solargraph = require("lsp.solargraph"),
        sqls = {},
        stimulus_ls= require("lsp.stimulus_ls"),
        stylelint_lsp={},
        svelte = { mason = false, },
        tailwindcss = require("lsp.tailwindcss"),
        texlab = {},
        textlsp = require("lsp.textlsp"),
        typos_lsp = { mason = true, },
        volar = require("lsp.volar"),
        vtsls = require("lsp.vtsls"),
        yamlls = require("lsp.yamlls"),
      },
    },
  },
  -- lazy.nvim
}
