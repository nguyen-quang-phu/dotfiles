return {
  ---@type lspconfig.settings.lua_ls
  settings = {
  ---@type _.lspconfig.settings.lua_ls.Lua
    Lua = {
      hint = {
        enable = true,
        paramName = "All",
        paramType = true,
        setType = true,
      },
    },
  },
}
