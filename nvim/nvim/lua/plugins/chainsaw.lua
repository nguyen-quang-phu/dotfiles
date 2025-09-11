---@type LazySpec
return {
  "chrisgrieser/nvim-chainsaw",
  keys = {
    { "<leader>ld", "<cmd>lua require('chainsaw').debugLog()<CR>",desc = "Log Debug" },
    { "<leader>lm", "<cmd>lua require('chainsaw').messageLog()<CR>", desc = "Log Message" },
    { "<leader>lo", "<cmd>lua require('chainsaw').objectLog()<CR>", desc = "Log Object" },
    { "<leader>lr", "<cmd>lua require('chainsaw').removeLogs()<CR>", desc = "Remove Logs" },
    { "<leader>lt", "<cmd>lua require('chainsaw').typeLog()<CR>", desc = "Log Type" },
    { "<leader>lv", "<cmd>lua require('chainsaw').variableLog()<CR>", desc = "Log Variable" },
  },
  opts = {
    marker = "♌️ Keynold 🗝️",
    logStatements = {
      variableLog = {
        javascript = "console.log('{{marker}} ~ {{filename}}:{{lnum}} ~ {{var}}:', {{var}});",
      },
      -- the same for the other log statement operations
    },
  },
}
