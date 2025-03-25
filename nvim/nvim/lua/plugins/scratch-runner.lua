return {
  "DestopLine/scratch-runner.nvim",
  opts = {
    {
      sources = {
        javascript = { "node" },
        python = { "python3" }, -- "py" or "python" if you are on Windows
        cs = { "dotnet-script" },
      },
    },
  },
}
