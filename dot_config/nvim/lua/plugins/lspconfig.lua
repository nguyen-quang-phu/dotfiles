return {
  "neovim/nvim-lspconfig",
  opts = {
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
      solargraph = {
        mason = false,
        settings = {
          solargraph = {
            diagnostics = false,
          },
        },
      },
    },
  },
  keys = {
    {
      "gr",
      false,
    },
  },
}
