---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>gy",
      function()
        require("yazi").yazi()
      end,
      desc = "Open the file manager",
    },
    -- {
    --   "<leader>-",
    --   mode = { "n", "v" },
    --   "<cmd>Yazi<cr>",
    --   desc = "Open yazi at the current file",
    -- },
    {
      -- Open in the current working directory
      "<leader>gY",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    -- {
    --   "<c-up>",
    --   "<cmd>Yazi toggle<cr>",
    --   desc = "Resume the last yazi session",
    -- },
    -- {
    --   -- Open in the current working directory
    --   "<leader>E",
    --   "<cmd>Yazi cwd<cr>",
    --   desc = "Open the file manager in nvim's working directory",
    -- },
    -- {
    --   -- Open in the current working directory
    --   "<leader><space>",
    --   function()
    --     require("yazi").yazi(nil, vim.fn.getcwd())
    --   end,
    --   desc = "Open the file manager in nvim's working directory",
    -- },
  },
  ---@type YaziConfig
  opts = {
    open_for_directories = false,
    keymap = {
      open = "<leader>e",
      open_cwd = "<leader>E",
    },
  },
}
