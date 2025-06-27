return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    enabled = true,
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup({
        config = vim.fn.expand("~/.config/nvim/mcpservers.json"),
        auto_approve = true,
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          }
        },
        log = {
          level = vim.log.levels.WARN,  -- DEBUG, INFO, WARN, ERROR
          to_file = true,  -- Creates ~/.local/state/nvim/mcphub.log
        },
        on_ready = function()
          vim.notify("MCP Hub is online!")
        end
      })
    end
  }
}
