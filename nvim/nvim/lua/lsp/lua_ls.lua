return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    ---@type _.lspconfig.settings.lua_ls.Lua
    Lua = {
      runtime = {
        version = "LuaJIT",
        special = { reload = "require" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME .. "/lua",
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          vim.fn.stdpath("config") .. "/lua",
        },
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable = true,
        paramName = "All",
        paramType = true,
        setType = true,
      },
    },
  },
}
