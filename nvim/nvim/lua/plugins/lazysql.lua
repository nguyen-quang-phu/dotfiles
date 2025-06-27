return {
{
  "LostbBlizzard/lazysql.nvim",
  opts = {},  -- automatically calls `require("lazysql").setup()`
    keys = { { "<leader>ls", "<cmd>LazySql<CR>", desc = "Toggle Lazy Sql" } },
  dependencies = {
    "MunifTanjim/nui.nvim",
  }
}
}
