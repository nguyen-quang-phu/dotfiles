return {
  "uga-rosa/translate.nvim",
  opts = {
    default = {
      command = "google",
      output = "split",
    },
    preset = {
      output = {
        split = {
          position = "bottom",
          min_size = 0.5,
          max_size = 0.5,
          name = "translate://output",
          filetype = "translate",
          append = false,
        },
      },
    },
  },
}
