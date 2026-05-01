return {
  mason = true,
  -- root_dir = require("lspconfig.util").root_pattern("package.json"),
  settings = {
    eslint = {
      workingDirectory = { mode = "auto" },
    },
  },
}
