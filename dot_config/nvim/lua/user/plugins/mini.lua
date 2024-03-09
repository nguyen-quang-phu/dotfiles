return {
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>k", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>K", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
}
