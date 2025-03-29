return {
  "DestopLine/scratch-runner.nvim",
  opts = {
    run_key = "<CR>",
    ---Key that switches between stdout and stderr.
    ---@type string?
    output_switch_key = "<Tab>",
    sources = {
      javascript = { "node" },
      python = { "python3" }, -- "py" or "python" if you are on Windows
      go = {
        function(file_path, _bin_path)
          return {
            { "go","run", file_path},
          }
        end,
        extension = "go",
      },
    },
  },
}
