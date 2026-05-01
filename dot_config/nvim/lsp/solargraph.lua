return {
  enabled = lsp == "solargraph",
  mason = false,
  settings = {
    solargraph = {
      diagnostics = false,
      useBundler = true,
    },
  },
}
